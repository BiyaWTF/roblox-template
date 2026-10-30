<#
Sincroniza el proceso común del molde (roblox-template) con los juegos.

Uso, desde la raíz del molde:
  .\tools\sync-proceso.ps1                          # todos los juegos, en seco
  .\tools\sync-proceso.ps1 -Juegos game1            # un juego, en seco
  .\tools\sync-proceso.ps1 -Aplicar                 # copia y hace commit
  .\tools\sync-proceso.ps1 -Aplicar -Push           # además hace push

Solo toca lo común. Lo de cada juego (CLAUDE.md, docs/, src/,
default.project.json, .gitignore) no se toca nunca, salvo crear
docs/MEJORAS-PROCESO.md si falta.
#>
param(
    [string[]]$Juegos,
    [switch]$Aplicar,
    [switch]$Push
)

$molde = Split-Path $PSScriptRoot -Parent
$raiz = Split-Path $molde -Parent

$carpetas = @('.claude\agents', '.claude\hooks', '.claude\rules', '.claude\skills')
$archivos = @('.claude\settings.json', 'stylua.toml', 'selene.toml', 'rokit.toml', '.gitattributes', '.vscode\settings.json')
# Skills que solo existen en el molde y no viajan a los juegos.
$soloMolde = @('mejorar')

function Test-SoloMolde([string]$rel) {
    foreach ($s in $soloMolde) {
        if ($rel -like ".claude\skills\$s\*") { return $true }
    }
    return $false
}

function Get-Comunes {
    $lista = New-Object System.Collections.Generic.List[string]
    foreach ($c in $carpetas) {
        $base = Join-Path $molde $c
        if (-not (Test-Path $base)) { continue }
        foreach ($f in Get-ChildItem $base -Recurse -File) {
            $rel = $f.FullName.Substring($molde.Length + 1)
            if (-not (Test-SoloMolde $rel)) { $lista.Add($rel) }
        }
    }
    foreach ($a in $archivos) {
        if (Test-Path (Join-Path $molde $a)) { $lista.Add($a) }
    }
    return $lista
}

if (git -C $molde status --porcelain) {
    Write-Host 'El molde tiene cambios sin commit. Haz commit antes de sincronizar.' -ForegroundColor Red
    exit 1
}
$hash = (git -C $molde rev-parse --short HEAD).Trim()

if (-not $Juegos) {
    $Juegos = Get-ChildItem $raiz -Directory |
        Where-Object { $_.FullName -ne $molde -and (Test-Path (Join-Path $_.FullName '.git')) -and (Test-Path (Join-Path $_.FullName '.claude')) } |
        ForEach-Object { $_.Name }
}

$comunes = Get-Comunes
$modo = if ($Aplicar) { 'APLICAR' } else { 'EN SECO' }
Write-Host "Molde $hash · modo $modo · juegos: $($Juegos -join ', ')"

foreach ($j in $Juegos) {
    $dir = Join-Path $raiz $j
    Write-Host ''
    Write-Host "=== $j" -ForegroundColor Cyan

    if (git -C $dir status --porcelain) {
        Write-Host 'OMITIDO: tiene cambios sin commit (¿sesión en curso?).' -ForegroundColor Yellow
        continue
    }
    git -C $dir fetch -q
    $detras = (git -C $dir rev-list --count 'HEAD..@{u}').Trim()
    if ($detras -ne '0') {
        Write-Host "OMITIDO: va $detras commit(s) por detrás de GitHub. Haz pull primero." -ForegroundColor Yellow
        continue
    }

    $nuevos = @(); $cambiados = @(); $borrar = @()
    foreach ($rel in $comunes) {
        $origen = Join-Path $molde $rel
        $destino = Join-Path $dir $rel
        if (-not (Test-Path $destino)) { $nuevos += $rel }
        elseif ((Get-FileHash $origen).Hash -ne (Get-FileHash $destino).Hash) { $cambiados += $rel }
    }
    foreach ($c in $carpetas) {
        $base = Join-Path $dir $c
        if (-not (Test-Path $base)) { continue }
        foreach ($f in Get-ChildItem $base -Recurse -File) {
            $rel = $f.FullName.Substring($dir.Length + 1)
            if (-not ($comunes -contains $rel)) { $borrar += $rel }
        }
    }
    $mejoras = 'docs\MEJORAS-PROCESO.md'
    $faltaMejoras = -not (Test-Path (Join-Path $dir $mejoras))

    $claude = Join-Path $dir 'CLAUDE.md'
    if ((Test-Path $claude) -and (Select-String -Path $claude -Pattern '^## Fin de cada sesión' -Quiet)) {
        Write-Host 'AVISO: CLAUDE.md con estructura antigua; hay que migrarlo (ver /mejorar, paso 5).' -ForegroundColor Yellow
    }

    if (-not ($nuevos.Count + $cambiados.Count + $borrar.Count) -and -not $faltaMejoras) {
        Write-Host 'Al día.' -ForegroundColor Green
        continue
    }
    $nuevos | ForEach-Object { Write-Host "  + $_" }
    $cambiados | ForEach-Object { Write-Host "  ~ $_" }
    $borrar | ForEach-Object { Write-Host "  - $_" }
    if ($faltaMejoras) { Write-Host "  + $mejoras (plantilla)" }

    if (-not $Aplicar) { continue }

    foreach ($rel in $nuevos + $cambiados) {
        $destino = Join-Path $dir $rel
        New-Item -ItemType Directory -Force (Split-Path $destino -Parent) | Out-Null
        Copy-Item (Join-Path $molde $rel) $destino -Force
    }
    foreach ($rel in $borrar) { Remove-Item (Join-Path $dir $rel) -Force }
    if ($faltaMejoras) { Copy-Item (Join-Path $molde $mejoras) (Join-Path $dir $mejoras) }

    $rutas = @('.claude', 'stylua.toml', 'selene.toml', 'rokit.toml', '.gitattributes', '.vscode', $mejoras) |
        Where-Object { Test-Path (Join-Path $dir $_) }
    git -C $dir add -A -- $rutas
    git -C $dir commit -q -m "Actualiza el proceso desde el molde ($hash)"
    Write-Host "Commit: $((git -C $dir log --oneline -1).Trim())" -ForegroundColor Green
    if ($Push) { git -C $dir push -q }
}
