# Tras cada Edit/Write: formatea con StyLua y pasa Selene al archivo .luau/.lua.
# Si Selene encuentra algo, sale con 2 para que Claude vea el aviso y lo corrija.
$data = [Console]::In.ReadToEnd() | ConvertFrom-Json
$file = $data.tool_input.file_path
if (-not $file -or $file -notmatch '\.(luau|lua)$') { exit 0 }

Set-Location $data.cwd
$bin = Join-Path $env:USERPROFILE '.rokit\bin'

& "$bin\stylua.exe" $file

$lint = & "$bin\selene.exe" --display-style quiet $file 2>&1
if ($LASTEXITCODE -ne 0) {
    [Console]::Error.WriteLine("Selene:`n" + ($lint | Out-String))
    exit 2
}
exit 0
