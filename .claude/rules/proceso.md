# Proceso de trabajo (común a todos los juegos)

> Este archivo viene del molde `roblox-template` y se sobrescribe al sincronizar.
> No lo edites en un juego: anota la mejora en `docs/MEJORAS-PROCESO.md`.

## Estado del proyecto (leer siempre al empezar)
- `docs/DESIGN.md`: qué juego es.
- `docs/BACKLOG.md`: funcionalidades, su estado y criterios de aceptación.
- `docs/DECISIONS.md`: decisiones tomadas y su motivo.
- `docs/MEJORAS-PROCESO.md`: mejoras del proceso detectadas, pendientes de llevar al molde.
La memoria del proyecto son estos archivos y Git, no la conversación: actualízalos
al cerrar cada tarea.

## Flujo de trabajo
- `/nuevo-juego [nombre]`: investigación de mercado y diseño → DESIGN + BACKLOG. Sin código.
- `/feature <F-00X>`: una funcionalidad por sesión (plan → código → calidad →
  luau-reviewer → studio-tester → playtest del usuario → commit).
- `/publicar <versión>`: checklist de publicación.
- Subagentes: `luau-reviewer` (revisión, solo lectura), `studio-tester` (pruebas
  en Studio vía MCP), `roblox-docs` (documentación oficial actual),
  `roblox-market` (mercado actual de Roblox: géneros, tendencias, competencia).
- Hook: cada Edit/Write de `.luau` pasa StyLua y Selene (`.claude/hooks/format-luau.ps1`).
- No cerrar las respuestas con opciones cerradas: el usuario analiza y decide.
- No modificar `.claude/` ni los archivos de configuración comunes en un juego:
  vienen del molde. Las mejoras se anotan en `docs/MEJORAS-PROCESO.md`.

## Fin de cada sesión
Cada skill termina con este cierre. No la des por terminada hasta cumplirlo.
1. Comprueba: documentos actualizados (BACKLOG, DECISIONS), calidad en verde si
   hubo código, commit y push hechos con OK del usuario y `git status` limpio.
2. Mejoras del proceso: repasa la sesión (fallos de una skill, pasos ambiguos,
   correcciones que tuvo que hacer el usuario, cosas que el revisor o el tester
   debieron detectar) y pregunta al usuario si quiere añadir algo. Anótalo en
   `docs/MEJORAS-PROCESO.md` (sección Pendientes) e inclúyelo en el commit.
3. Si falta algo, dilo claramente y NO anuncies el final.
4. Mensaje final, siempre con este formato:
   ✅ /<skill> terminada: <qué se ha conseguido, en una frase>
   - Hecho: <puntos clave>
   - Mejoras del proceso anotadas: <cuántas, o ninguna>
   - Git: <commit> subido (o qué falta)
   - Siguiente paso: cierra esta sesión, abre una nueva en <carpeta del juego>
     y ejecuta `<comando>` (<nombre de la funcionalidad o tarea>).
   - Antes de empezar: <preparación concreta>
5. Cómo elegir el siguiente comando (mirando docs/BACKLOG.md):
   - Tras /nuevo-juego: `/feature` con la primera funcionalidad pendiente.
   - Tras /feature: la siguiente pendiente del mismo hito.
   - Hito completado: si es publicable (hito 2 en adelante), `/publicar <versión>`;
     si es el prototipo, la primera del siguiente hito (publicar solo si el
     usuario quiere probarlo con amigos). Explica la opción.
   - Tras /publicar: la primera pendiente del siguiente hito, y revisar las
     métricas del Creator Hub pasados unos días.
   - BACKLOG sin pendientes: proponer con el usuario el siguiente hito.
   - Si hay mejoras pendientes en `docs/MEJORAS-PROCESO.md`, recuerda que se
     aplican con `/mejorar` en una sesión abierta en `C:\roblox-games\roblox-template`.
   Preparación típica: para /feature, Studio abierto con el lugar del juego
   (Claude arranca `rojo serve`); para /publicar, el lugar guardado en Studio.

## Git
- No se versionan: `sourcemap.json`, `globalTypes.d.luau`, `*.rbxl(x)`, `*.lock`, `build/`.
- `.gitattributes` fuerza LF (el Git global tiene `core.autocrlf=true`).
- Commits en español, en imperativo y descriptivos. Commit y push solo con OK del usuario.
- Sin línea `Co-Authored-By` ni otra atribución a Claude en commits ni PRs.
