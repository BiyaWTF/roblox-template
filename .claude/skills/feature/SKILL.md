---
name: feature
description: Implementa una funcionalidad del BACKLOG siguiendo el flujo completo (plan, código, calidad, revisión, test en Studio, playtest, commit).
argument-hint: [F-00X]
disable-model-invocation: true
---
Funcionalidad a implementar: $ARGUMENTS (si está vacío, la primera pendiente del BACKLOG).
Una funcionalidad por sesión.

1. Contexto: lee CLAUDE.md, docs/DESIGN.md, docs/BACKLOG.md y docs/DECISIONS.md.
2. Plan: archivos a crear o cambiar, RemoteEvents (con su validación), datos
   persistentes, criterios de aceptación. Enséñalo y espera aprobación.
   Si usa APIs nuevas, consulta antes al subagente roblox-docs.
3. Implementa en src/ siguiendo CLAUDE.md. El hook formatea y pasa Selene en cada
   edición; corrige lo que reporte.
4. Calidad completa: stylua --check src, selene src y luau-lsp analyze (comando en
   CLAUDE.md). Todo en verde antes de seguir.
5. Delega en luau-reviewer con la lista de archivos cambiados y la descripción.
   Corrige CRÍTICO y ALTO; comenta con el usuario MEDIO y BAJO.
6. Pide al usuario que tenga Studio abierto con Rojo conectado (o arranca
   rojo serve y espera su confirmación). Delega en studio-tester con el nombre del
   lugar y los criterios. Si algo falla, vuelve al paso 3.
7. Pide al usuario que lo juegue. Aplica sus cambios y repite 4-6 si son de código.
8. Cierre, con OK del usuario: marca la funcionalidad como hecha en BACKLOG (con
   notas), añade a DECISIONS lo decidido, commit en español y push.
   Recomienda cerrar la sesión o usar /clear antes de la siguiente funcionalidad.
