# roblox-template

Plantilla (molde) para crear juegos de Roblox con Claude Code. No contiene ningún
juego: solo la forma de trabajar.

## Crear un juego nuevo
1. En GitHub, en este repo: **Use this template → Create a new repository**.
2. Clonar el repo nuevo en `C:\roblox-games\<juego>`.
3. Descargar las definiciones de tipos (no se versionan):
   `Invoke-WebRequest https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/globalTypes.d.luau -OutFile globalTypes.d.luau`
4. Abrir Claude Code en esa carpeta y ejecutar `/nuevo-juego [nombre]`.
5. Una sesión por funcionalidad: `/feature F-001`, `/feature F-002`…
6. Al completar un hito: `/publicar <versión>`.

La skill `/mejorar` y la carpeta `tools/` también llegan al juego nuevo, pero solo
se usan en el molde. La primera sincronización retira `/mejorar` del juego; `tools/`
se puede borrar a mano.

## Contenido
- `CLAUDE.md`: solo lo propio de cada juego (nombre, repo, particularidades).
- `.claude/rules/`: reglas comunes (proceso, entorno, Luau). Se cargan solas.
- `.claude/skills/`: `nuevo-juego`, `feature`, `publicar` y `mejorar` (solo molde).
- `.claude/agents/`: `luau-reviewer`, `studio-tester`, `roblox-docs`, `roblox-market`.
- `.claude/settings.json` + `.claude/hooks/format-luau.ps1`: permisos y hook StyLua + Selene.
- `docs/`: plantillas de DESIGN, BACKLOG, DECISIONS y MEJORAS-PROCESO.
- `tools/sync-proceso.ps1`: sincroniza lo común del molde a los juegos.
- Configuración: Rojo, Rokit, StyLua, Selene, VS Code.

## Mejorar el proceso (circuito de mejora)
1. Las sesiones de cada juego anotan lo que falla o se puede mejorar en
   `docs/MEJORAS-PROCESO.md` al cerrar.
2. En una sesión abierta en este repo, `/mejorar` recoge esas notas, propone y
   aplica los cambios aquí y los sincroniza a los juegos con `tools/sync-proceso.ps1`.
3. Los juegos con una sesión a medias se omiten y se sincronizan la próxima vez.
Todo se documenta en el artefacto "Flujo de desarrollo Roblox".
