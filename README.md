# roblox-template

Plantilla (molde) para crear juegos de Roblox con Claude Code. No contiene ningún
juego: solo la forma de trabajar.

## Crear un juego nuevo
1. En GitHub, en este repo: **Use this template → Create a new repository**.
2. Clonar el repo nuevo en `C:\roblox-games\<juego>`.
3. Descargar las definiciones de tipos (no se versionan):
   `Invoke-WebRequest https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/globalTypes.d.luau -OutFile globalTypes.d.luau`
4. Abrir Claude Code en esa carpeta y ejecutar `/nuevo-juego <nombre>`.
5. Una sesión por funcionalidad: `/feature F-001`, `/feature F-002`…
6. Al completar un hito: `/publicar <versión>`.

## Contenido
- `.claude/skills/`: `nuevo-juego`, `feature`, `publicar`.
- `.claude/agents/`: `luau-reviewer`, `studio-tester`, `roblox-docs`.
- `.claude/settings.json` + `.claude/hooks/format-luau.ps1`: permisos y hook StyLua + Selene.
- `docs/`: plantillas de DESIGN, BACKLOG y DECISIONS.
- Configuración: Rojo, Rokit, StyLua, Selene, VS Code.

## Mejorar el proceso
Los cambios al flujo se hacen aquí y se documentan en el artefacto
"Flujo de desarrollo Roblox". Los juegos ya creados pueden traerse los cambios
copiando la carpeta `.claude/`.
