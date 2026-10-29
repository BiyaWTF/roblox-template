---
name: nuevo-juego
description: Diseña un juego nuevo con el usuario mediante una entrevista y genera docs/DESIGN.md y docs/BACKLOG.md.
argument-hint: [nombre-del-juego]
disable-model-invocation: true
model: opus
effort: high
---
Vamos a diseñar el juego "$ARGUMENTS". En esta skill NO se escribe código.

1. Lee CLAUDE.md y las plantillas de docs/.
2. Entrevista por rondas cortas (máximo 4 preguntas por ronda). Espera la
   respuesta de cada ronda antes de seguir. Ofrece ideas, pero decide el usuario.
   - Ronda 1: género, tema, público objetivo, juegos del género que le gustan y
     qué cambiaría (referencia de género, nunca copiar un juego concreto).
   - Ronda 2: bucle principal (qué hace el jugador cada 30 s, en cada sesión y
     por qué vuelve al día siguiente).
   - Ronda 3: progresión, componente social, monetización (game passes y
     productos de desarrollador, sin pay-to-win agresivo).
   - Ronda 4: alcance de la v1: qué entra y qué queda fuera explícitamente.
3. Redacta docs/DESIGN.md con la plantilla. Enséñaselo y corrige hasta que lo apruebe.
4. Deriva docs/BACKLOG.md: funcionalidades pequeñas y verticales (F-001, F-002…),
   cada una con criterios de aceptación comprobables. Hito 1 = prototipo gris
   jugable con el bucle principal, sin arte.
5. Pon el nombre del juego en CLAUDE.md (título y repo) y en el campo "name" de
   default.project.json. Registra en docs/DECISIONS.md las decisiones de diseño.
6. Con el OK del usuario: commit y push. Termina recordando que la siguiente
   sesión empieza con /feature F-001.
