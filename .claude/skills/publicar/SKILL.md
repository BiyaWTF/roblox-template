---
name: publicar
description: Checklist guiado para publicar o actualizar el juego en Roblox.
argument-hint: [version, p.ej. 0.1.0]
disable-model-invocation: true
model: opus
effort: medium
---
Vamos a publicar la versión $ARGUMENTS. Claude comprueba; el usuario publica.

1. Calidad: stylua --check, selene, luau-lsp analyze en verde; BACKLOG sin
   funcionalidades del hito a medias.
2. Test final con studio-tester de los criterios del hito completo.
3. Revisa (consultando a roblox-docs si hay dudas) los requisitos vigentes:
   cuestionario de madurez, audiencia (16+ o todas las edades), verificación de
   cuenta necesaria.
4. Lista para el usuario: nombre, descripción, icono 512x512, miniaturas,
   género, dispositivos, game passes y productos creados y con precio.
5. El usuario publica desde Studio (Archivo → Publicar en Roblox).
6. Commit, etiqueta git v$ARGUMENTS, push con etiquetas y nota en DECISIONS.
7. Sigue «Fin de cada sesión» de CLAUDE.md: confirma que todo está hecho y di
   cuál es el siguiente paso.
