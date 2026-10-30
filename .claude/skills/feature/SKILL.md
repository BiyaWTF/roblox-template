---
name: feature
description: Implementa una funcionalidad del BACKLOG siguiendo el flujo completo (plan, código, calidad, revisión, test en Studio, playtest, commit).
argument-hint: [F-00X]
disable-model-invocation: true
model: opus
effort: high
---
Funcionalidad a implementar: $ARGUMENTS (si está vacío, la primera pendiente del BACKLOG).
Una funcionalidad por sesión. Durante toda la sesión, cualquier idea que surja y no
entre en esta funcionalidad (fuera de alcance, ideas del playtest, avisos del
revisor que no se arreglan ahora) se apunta en Propuestas de docs/BACKLOG.md con su
origen y fecha. No se implementa.

1. Contexto: lee CLAUDE.md, docs/DESIGN.md, docs/BACKLOG.md y docs/DECISIONS.md.
   Si la funcionalidad pertenece a un hito que todavía está en esbozo (sin
   criterios), detalla antes el hito con el usuario: revisa las Propuestas, decide
   qué entra y escribe los criterios de cada funcionalidad. Espera su aprobación.
2. Plan, con estos apartados:
   - Archivos a crear o cambiar.
   - RemoteEvents (con su validación) y datos persistentes.
   - Cambios de configuración del lugar o del proyecto (default.project.json,
     propiedades de Workspace o StarterPlayer), marcados aparte porque afectan
     a todo el juego.
   - Criterios de aceptación y cómo se comprueba cada uno (studio-tester o
     playtest del usuario).
   - Fuera de alcance: lo que no se hace en esta funcionalidad (va a Propuestas
     si merece la pena).
   - Riesgos y supuestos: streaming, física, rendimiento, valores por defecto.
   - Impacto en otras funcionalidades pendientes, si lo hay.
   Enséñalo y espera aprobación. Si usa APIs nuevas, consulta antes a roblox-docs.
   Si el usuario corrige el plan después de aprobarlo, aplica la corrección y
   anótala como mejora del proceso si el plan debió preverla.
3. Implementa en src/ siguiendo .claude/rules/luau.md. El hook formatea y pasa
   Selene en cada edición; corrige lo que reporte.
4. Calidad completa: stylua --check src, selene src y luau-lsp analyze (comando en
   .claude/rules/entorno.md). Todo en verde antes de seguir.
5. Delega en luau-reviewer con la lista de archivos cambiados y la descripción.
   Corrige CRÍTICO y ALTO; comenta con el usuario MEDIO y BAJO.
6. Prueba en Studio:
   a. Arranca tú `rojo serve` en segundo plano en la raíz del proyecto y comprueba
      en su salida que escucha (puerto 34872 por defecto). No pidas al usuario que
      conecte hasta verlo.
   b. Pide al usuario que abra Studio con el lugar del juego y pulse
      Plugins → Rojo → Connect → Accept. Espera su confirmación.
   c. Delega en studio-tester con el nombre del lugar y los criterios. Si algo
      falla, vuelve al paso 3.
7. Pide al usuario que lo juegue. Aplica sus cambios y repite 4-6 si son de código.
8. Backlog, con el usuario:
   - Marca la funcionalidad como hecha (con notas).
   - Si lo hecho cambia funcionalidades pendientes (criterios, orden, o alguna
     sobra), actualízalas y deja constancia en su apartado Cambios.
   - Repasa las Propuestas nuevas de esta sesión: cada una se aprueba (pasa a un
     hito como F-0XX; con criterios si es del hito actual), se descarta (a
     Propuestas descartadas, con el motivo) o se deja para más adelante.
9. Cierre, con OK del usuario: añade a DECISIONS lo decidido, commit en español y
   push.
10. Sigue «Fin de cada sesión» de .claude/rules/proceso.md: confirma que todo está
    hecho y di cuál es el siguiente paso.
