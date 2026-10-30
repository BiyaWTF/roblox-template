# <nombre-del-juego> – Proyecto Roblox

Repo: <url del repo en GitHub> (rama `main`). Creado desde la plantilla `roblox-template`.

## Estado del proyecto (leer siempre al empezar)
- `docs/DESIGN.md`: qué juego es.
- `docs/BACKLOG.md`: funcionalidades, su estado y criterios de aceptación.
- `docs/DECISIONS.md`: decisiones tomadas y su motivo.
La memoria del proyecto son estos archivos y Git, no la conversación: actualízalos
al cerrar cada tarea.

## Flujo de trabajo
- `/nuevo-juego <nombre>`: entrevista de diseño → DESIGN + BACKLOG. Sin código.
- `/feature <F-00X>`: una funcionalidad por sesión (plan → código → calidad →
  luau-reviewer → studio-tester → playtest del usuario → commit).
- `/publicar <versión>`: checklist de publicación.
- Subagentes: `luau-reviewer` (revisión, solo lectura), `studio-tester` (pruebas
  en Studio vía MCP), `roblox-docs` (documentación oficial actual),
  `roblox-market` (mercado actual de Roblox: géneros, tendencias, monetización).
- Hook: cada Edit/Write de `.luau` pasa StyLua y Selene (`.claude/hooks/format-luau.ps1`).
- No cerrar las respuestas con opciones cerradas: el usuario analiza y decide.

## Fin de cada sesión
Cada skill termina con este cierre. No la des por terminada hasta cumplirlo.
1. Comprueba: documentos actualizados (BACKLOG, DECISIONS), calidad en verde si
   hubo código, commit y push hechos con OK del usuario y `git status` limpio.
2. Si falta algo, dilo claramente y NO anuncies el final.
3. Mensaje final, siempre con este formato:
   ✅ /<skill> terminada: <qué se ha conseguido, en una frase>
   - Hecho: <puntos clave>
   - Git: <commit> subido (o qué falta)
   - Siguiente paso: cierra esta sesión, abre una nueva en <carpeta del juego>
     y ejecuta `<comando>` (<nombre de la funcionalidad o tarea>).
   - Antes de empezar: <preparación concreta>
4. Cómo elegir el siguiente comando (mirando docs/BACKLOG.md):
   - Tras /nuevo-juego: `/feature` con la primera funcionalidad pendiente.
   - Tras /feature: la siguiente pendiente del mismo hito.
   - Hito completado: si es publicable (hito 2 en adelante), `/publicar <versión>`;
     si es el prototipo, la primera del siguiente hito (publicar solo si el
     usuario quiere probarlo con amigos). Explica la opción.
   - Tras /publicar: la primera pendiente del siguiente hito, y revisar las
     métricas del Creator Hub pasados unos días.
   - BACKLOG sin pendientes: proponer con el usuario el siguiente hito.
   Preparación típica: para /feature, Studio abierto con el lugar del juego
   (Claude arranca `rojo serve`); para /publicar, el lugar guardado en Studio.
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
- El código vive en `src/`; Git es la fuente de verdad.
  1. `rojo serve`
  2. En Studio: Plugins → Rojo → Connect → revisar cambios → Accept
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

## Convenciones Luau
- `--!strict` en todos los módulos.
- Nombres de archivo: `*.server.luau` (Script), `*.client.luau` (LocalScript),
  ModuleScripts en `PascalCase.luau`; `init.*.luau` = la carpeta se convierte en ese script.
- Servicios con `game:GetService`; `task.wait`/`task.spawn`/`task.delay` (nunca `wait`/`spawn`).
- Validar en servidor todo lo que llegue por RemoteEvents/RemoteFunctions; no confiar en el cliente.
- Formato: StyLua (tabs, 120 columnas, comillas dobles, LF). Lint: Selene (`std = "roblox"`).

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

## Git
- No se versionan: `sourcemap.json`, `globalTypes.d.luau`, `*.rbxl(x)`, `*.lock`, `build/`.
- `.gitattributes` fuerza LF (el Git global tiene `core.autocrlf=true`).
- Commits en español, en imperativo y descriptivos. Commit y push solo con OK del usuario.
- Sin línea `Co-Authored-By` ni otra atribución a Claude en commits ni PRs.

## Antes de dar algo por terminado
1. `stylua --check src` y `selene src` sin errores.
2. `luau-lsp analyze ...` sin errores de tipos.
3. Playtest vía MCP (studio-tester) sin errores en la consola, y OK del usuario.
