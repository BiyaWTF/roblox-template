---
name: nuevo-juego
description: Busca con el usuario el concepto de juego con más potencial de retención y de ingresos (basado en el mercado actual de Roblox) y genera docs/DESIGN.md y docs/BACKLOG.md.
argument-hint: [nombre-provisional, opcional]
disable-model-invocation: true
model: opus
effort: high
---
Vamos a diseñar un juego nuevo (nombre provisional: "$ARGUMENTS", puede estar vacío).
Objetivo: el concepto con más potencial de enganche y de ingresos que sea viable
para un desarrollador solo con ayuda de IA, original y dentro de las normas de
Roblox. En esta skill NO se escribe código.

## Fase 1 · Investigación (antes de preguntar nada)
1. Lee CLAUDE.md y las plantillas de docs/.
2. Lanza en paralelo:
   - roblox-market: géneros y mecánicas dominantes hoy, tendencias, cómo
     monetizan, saturación, viabilidad para un desarrollador solo.
   - roblox-docs: reglas vigentes de monetización (game passes, productos de
     desarrollador, artículos aleatorios de pago, Premium Payouts, suscripciones)
     y requisitos de audiencia y cuestionario de madurez.
3. Resume al usuario lo relevante en pocas líneas, con las fuentes.

## Fase 2 · Perfil (una ronda, máximo 4 preguntas)
Tiempo semanal disponible, géneros que le gustan o que odia, qué sabe hacer
(arte, modelado, UI) y si prefiere lanzar rápido algo pequeño o apostar por algo
más grande. Espera la respuesta.

## Fase 3 · Conceptos
Propón 3-5 conceptos originales (inspirados en géneros y mecánicas, nunca copia
de un juego concreto). Para cada uno:
- La fantasía en una frase.
- Bucle: qué hace cada 30 s, en cada sesión y por qué vuelve mañana.
- Ganchos de retención y de monetización concretos.
- Coste de desarrollo y dependencia del arte.
- Prueba de diferenciación: en una frase, por qué alguien dejaría el juego
  parecido más popular para jugar a este. Sin respuesta clara, el concepto no pasa.

Antes de enseñarlos, pasa la lista a roblox-market para el análisis de
competencia. Descarta o replantea los conceptos que choquen con un juego
dominante bien hecho o que no superen la prueba de diferenciación.

Presenta cada concepto con sus juegos parecidos y su categoría (Hueco / Mal
ejecutado / Fórmula probada). Inspirarse en una fórmula probada sí; copiar un
juego concreto (nombre, aspecto, assets, código) no.

Puntúa cada uno de 1 a 5 en una tabla: retención, ingresos, viabilidad (solo +
IA), competencia, diferenciación y riesgo. Recomienda uno y explica por qué, pero
decide el usuario. Se pueden combinar o iterar conceptos. No avances sin su elección.

## Fase 4 · Diseño del concepto elegido (rondas de máximo 4 preguntas)
Recorre con el usuario, usando estas listas como guía:

Retención:
- Primera experiencia: recompensa en los primeros 30-60 s y objetivo claro.
- Progreso visible constante y objetivos a corto, medio y largo plazo.
- Recompensas variables, coleccionables, prestigio o renacer.
- Recompensas diarias y rachas; eventos y actualizaciones periódicas.
- Social: jugar con amigos, intercambio, clasificaciones, invitar.

Monetización:
- Game passes permanentes (multiplicadores, VIP, automatizaciones, zonas).
- Productos de desarrollador (impulsos, moneda, saltar esperas).
- Premium Payouts: Roblox paga por el tiempo de juego de usuarios Premium, así
  que la retención también es dinero.
- Cosméticos y servidores privados. Precios escalonados (barato, medio, alto).

Límites no negociables:
- Cumplir los Términos, las Normas de la Comunidad y las políticas de
  monetización vigentes (verificadas con roblox-docs). Artículos aleatorios de
  pago solo si están permitidos y mostrando las probabilidades.
- Nada de patrones engañosos: compras disfrazadas, botones de compra confusos,
  cuentas atrás falsas, pay-to-win que arruine el juego a quien no paga.
- El público incluye muchos menores: tenerlo en cuenta en el diseño, el
  cuestionario de madurez y la audiencia objetivo.

Cierra con el alcance de la v1: qué entra y qué queda fuera explícitamente.

## Fase 5 · Documentos
1. Redacta docs/DESIGN.md con la plantilla (incluida la investigación y las
   métricas objetivo). Enséñaselo y corrige hasta que lo apruebe.
2. Deriva docs/BACKLOG.md con la plantilla. Es un punto de partida, no un plan
   cerrado: cambiará al jugar.
   - Hito 1, detallado: prototipo gris jugable con el bucle principal, sin arte.
     Funcionalidades pequeñas y verticales (F-001…), cada una con criterios de
     aceptación comprobables.
   - Hito 2 en adelante, en esbozo (una línea por funcionalidad): retención
     mínima (guardado, progresión, recompensa diaria) y primeras compras; luego
     contenido y eventos. Se detallan al empezar cada hito.
   - Lo que quedó fuera de la v1 y merece la pena, a Propuestas.
3. Pon el nombre del juego en CLAUDE.md (título y repo) y en el campo "name" de
   default.project.json. Registra en docs/DECISIONS.md las decisiones de diseño
   y por qué se descartaron los otros conceptos.
4. Con el OK del usuario: commit y push.

## Cierre
Sigue «Fin de cada sesión» de .claude/rules/proceso.md: confirma que todo está hecho y di cuál
es el siguiente paso.
