---
name: mejorar
description: Aplica al molde las mejoras del proceso anotadas en los juegos (y las que indique el usuario) y las sincroniza a todos los juegos. Solo se usa en roblox-template.
argument-hint: [mejora concreta, opcional]
disable-model-invocation: true
model: opus
effort: high
---
Mejora del proceso. Mejora adicional indicada por el usuario: "$ARGUMENTS" (puede estar vacía).

0. Comprueba que estás en el molde: `git remote get-url origin` debe contener
   `roblox-template`. Si no, detente y explica que esta skill solo se usa en una
   sesión abierta en C:\roblox-games\roblox-template.
1. Recoge las mejoras: la sección Pendientes de `docs/MEJORAS-PROCESO.md` de cada
   juego en C:\roblox-games\ (carpetas con .git y .claude, salvo el molde), más la
   del usuario. Si no hay ninguna, dilo y termina.
2. Propón, agrupado por archivo del molde, el cambio concreto para cada mejora, o
   por qué no conviene aplicarla. Espera la aprobación del usuario.
3. Aplica en el molde, respetando qué es común y qué es de cada juego:
   - Común (se sincroniza): `.claude/agents`, `.claude/hooks`, `.claude/rules`,
     `.claude/skills`, `.claude/settings.json`, `stylua.toml`, `selene.toml`,
     `rokit.toml`, `.gitattributes`, `.vscode/settings.json`.
   - De cada juego (nunca se sobrescribe): `CLAUDE.md`, `docs/`, `src/`,
     `default.project.json`, `.gitignore`.
   - Una mejora que solo afecta a un juego va a su `CLAUDE.md`, no al molde.
   Comprueba lo que toques: si es el hook, pruébalo con un JSON de ejemplo; si son
   skills o subagentes, que el frontmatter siga siendo válido.
4. Con OK del usuario: commit y push en el molde. El script exige el molde limpio.
5. Ejecuta `.\tools\sync-proceso.ps1` (en seco) y enseña el resultado. Se omiten
   los juegos con cambios sin commit o por detrás de GitHub, porque suelen tener
   una sesión en curso: di cuáles quedan pendientes.
   Si el script avisa de un CLAUDE.md con estructura antigua, mígralo en ese juego:
   conserva solo lo propio del juego (nombre, repo, particularidades) y quita las
   secciones que ya están en `.claude/rules/`. Enséñaselo al usuario.
6. En los juegos sincronizables: mueve las mejoras aplicadas de Pendientes a
   Aplicadas (con fecha y commit del molde) y las rechazadas a Descartadas (con el
   motivo). Haz commit de esos archivos en cada juego.
7. Con OK del usuario: `.\tools\sync-proceso.ps1 -Aplicar -Push`.
8. Actualiza el documento del flujo: fuente `C:\roblox-games\docs\flujo-roblox.html`,
   publicado en https://claude.ai/artifact/QZ3cVQTirTrr52QzPXXmVW. Léelo antes con
   la herramienta Artifact (acción read) y publica con su `url`. Actualiza las
   secciones afectadas y añade una entrada al registro de cambios.
9. Cierre según «Fin de cada sesión» de .claude/rules/proceso.md, indicando qué
   juegos quedan por sincronizar.
