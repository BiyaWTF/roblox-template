<#
Rellena los bloques de código del documento del flujo con el contenido real de
los archivos del molde, para que el documento nunca quede desfasado.

Un bloque se rellena si su cabecera es una ruta del molde y lleva etiqueta:
  <div class="file"><div class="file-head"><span>RUTA</span><span class="tag">…</span></div><pre><code>…</code></pre>

Uso, desde la raíz del molde:
  .\tools\actualizar-doc-flujo.ps1
  .\tools\actualizar-doc-flujo.ps1 -Doc C:\ruta\al\documento.html
#>
param(
    [string]$Doc
)

$molde = Split-Path $PSScriptRoot -Parent
if (-not $Doc) { $Doc = Join-Path (Split-Path $molde -Parent) 'docs\flujo-roblox.html' }

$html = [IO.File]::ReadAllText($Doc)
$patron = '(<div class="file"><div class="file-head"><span>)([^<]+)(</span><span class="tag">)[^<]*(</span></div><pre><code>)(.*?)(</code></pre>)'
$regex = New-Object Text.RegularExpressions.Regex($patron, [Text.RegularExpressions.RegexOptions]::Singleline)

$script:rellenados = @()
$script:sinArchivo = @()
$evaluador = [Text.RegularExpressions.MatchEvaluator] {
    param($m)
    $rel = $m.Groups[2].Value
    $ruta = Join-Path $molde ($rel -replace '/', '\')
    if (-not (Test-Path $ruta -PathType Leaf)) {
        $script:sinArchivo += $rel
        return $m.Value
    }
    $texto = [IO.File]::ReadAllText($ruta).Replace("`r`n", "`n").TrimEnd("`n")
    $texto = $texto.Replace('&', '&amp;').Replace('<', '&lt;').Replace('>', '&gt;')
    $script:rellenados += $rel
    return $m.Groups[1].Value + $rel + $m.Groups[3].Value + 'en el molde' + $m.Groups[4].Value + $texto + $m.Groups[6].Value
}

$nuevo = $regex.Replace($html, $evaluador)
[IO.File]::WriteAllText($Doc, $nuevo, (New-Object Text.UTF8Encoding $false))

Write-Host "Rellenados ($($script:rellenados.Count)):"
$script:rellenados | ForEach-Object { Write-Host "  $_" }
if ($script:sinArchivo.Count) {
    Write-Host "Sin archivo en el molde ($($script:sinArchivo.Count)):" -ForegroundColor Yellow
    $script:sinArchivo | ForEach-Object { Write-Host "  $_" }
}
