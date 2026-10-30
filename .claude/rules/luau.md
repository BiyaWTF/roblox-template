# Convenciones Luau y calidad (común a todos los juegos)

> Este archivo viene del molde `roblox-template` y se sobrescribe al sincronizar.

## Convenciones
- `--!strict` en todos los módulos.
- Nombres de archivo: `*.server.luau` (Script), `*.client.luau` (LocalScript),
  ModuleScripts en `PascalCase.luau`; `init.*.luau` = la carpeta se convierte en ese script.
- Servicios con `game:GetService`; `task.wait`/`task.spawn`/`task.delay` (nunca `wait`/`spawn`).
- Validar en servidor todo lo que llegue por RemoteEvents/RemoteFunctions; no confiar en el cliente.
- Partes del mundo creadas por código: `Anchored = true` salvo que deban moverse por física.
- Si algo debe ser reproducible (semillas, generación procedural), recorrer arrays
  con `ipairs` o claves ordenadas; nunca depender del orden de `pairs` en diccionarios.
- Tener en cuenta StreamingEnabled: el cliente puede no tener cargadas partes lejanas.
  Lo que se decida para el juego se registra en `docs/DECISIONS.md`.
- Formato: StyLua (tabs, 120 columnas, comillas dobles, LF). Lint: Selene (`std = "roblox"`).

## Antes de dar algo por terminado
1. `stylua --check src` y `selene src` sin errores.
2. `luau-lsp analyze ...` sin errores de tipos.
3. Playtest vía MCP (studio-tester) sin errores en la consola, y OK del usuario.
