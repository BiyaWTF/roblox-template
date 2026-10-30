# Entorno y herramientas (común a todos los juegos)

> Este archivo viene del molde `roblox-template` y se sobrescribe al sincronizar.

## Entorno
- Windows 11 Pro · PowerShell · VS Code · Git → GitHub
- Herramientas fijadas en `rokit.toml` (binarios en `%USERPROFILE%\.rokit\bin`):
  rojo · stylua · selene · luau-lsp
- Extensiones de VS Code: evaera.vscode-rojo, JohnnyMorganz.luau-lsp,
  JohnnyMorganz.stylua, Kampfkarren.selene-vscode
- Plugin de Rojo 7 instalado en Studio.
- MCP de Roblox Studio registrado en Claude Code (scope user) como `Roblox_Studio`.
  En Studio: Asistente → Servidores MCP → "Habilitar Studio como servidor MCP".

## Rojo
- El código vive en `src/`; Git es la fuente de verdad. Rojo lo lleva a Studio.
  1. Claude arranca `rojo serve` en segundo plano y comprueba que escucha (puerto 34872).
  2. El usuario, en Studio: Plugins → Rojo → Connect → revisar cambios → Accept.
- Mapeo (`default.project.json`):
  `src/server` → ServerScriptService.Server · `src/client` → StarterPlayerScripts.Client ·
  `src/shared` → ReplicatedStorage.Shared
- Trabajar en un lugar propio del juego, nunca en lugares ajenos o de tutorial.

## Uso del MCP de Studio
- Primero `list_roblox_studios` (los `studio_id` cambian en cada apertura) y elegir por nombre.
- Úsalo para inspeccionar el árbol, `execute_luau`, playtest (`start_stop_play`) y consola.
- NO editar con MCP (`multi_edit`) scripts gestionados por Rojo: se sobrescriben. Editar en `src/`.
- Confirmar con el usuario antes de modificar contenido del lugar (Parts, Models, Terrain).
- En `execute_luau`, trabajo pesado en lotes con `task.wait()` para no congelar Studio.

## Comandos (PowerShell, en la raíz del proyecto)
```powershell
rojo serve
rojo sourcemap default.project.json --output sourcemap.json
stylua src            # formatear
stylua --check src    # comprobar (exit 1 si hay diferencias)
selene src            # linter
luau-lsp analyze --platform=roblox --definitions=@roblox=globalTypes.d.luau --sourcemap=sourcemap.json src
```
- `globalTypes.d.luau` no se versiona. Si falta o está desactualizado:
  `Invoke-WebRequest https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/globalTypes.d.luau -OutFile globalTypes.d.luau`
- Si `rojo`/`stylua`/... no se encuentran: `$env:PATH = "$env:USERPROFILE\.rokit\bin;$env:PATH"`.
