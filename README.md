# Guardando cosas en la academia de magia

En una academia de magia siempre hay lío para encontrar las cosas que se guardan, 
tanto es así que han decidido hacer un software que ayude a la administración de los muebles 
y cosas guardadas

## Aclaraciones sobre el parcial
- El parcial es **individual** y se entrega **pusheando a este repositorio** como en las entregas anteriores. Recomendamos _ir pusheando cada cierto tiempo_ para evitar inconvenientes, lo ideal es después de cada punto resuelto.
- No se tendrán en cuenta los commits realizados después de la hora de finalización del examen.
- Una vez hecho el _push_ final, **verifiquen en github.com** que haya quedado la versión final. Nosotros corregiremos lo que está en github, si ustedes lo pueden ver ahí entonces nosotros también.
- No olvidarse de **los conceptos aprendidos**: polimorfismo, delegación, buenas abstracciones, no repetir lógica, guardar vs calcular, lanzar excepción cuando un método no puede cumplir con su responsabilidad, etc. Eso es lo que se está evaluando.
- La solución del examen consiste en la **implementación de un programa** que resuelva los requerimientos pedidos y sus **tests automatizados**.
- Este enunciado es acompañado con un archivo `.wtest` que tiene diseñado los test a realizar. Es importante aclarar que:
  - Estos tests se proponen para facilitar el desarrollo. Se puede diseñar otros si así se considera necesario.
  - El conjunto de tests propuesto es suficiente para este ejercicio. No hace falta agregar nuevos, pero tampoco se prohibe hacerlo.
  - Todos los objetos allí usados se asumen como instancias de una clase. Si el diseño de la solución utiliza objetos bien conocidos en algunos casos entonces se debe remover la declaración de la variable y la línea en que se sugiere la instanciación
  - Según el diseño de la solución, es probable que se requiera agregar más objetos a los sugeridos en los tests
  - Los tests están comentados de manera de poder _ir incorporándolos a medida que se avanza_ con la solución del ejercicio



## Parte 1:  Muebles y cosas

De las cosas que se pueden guardar interesa saber la **marca**, el **volumen**, 
si **es un elemento mágico**, y si **es una reliquia**. Estas características son conocidas 
para cada cosa en particular. 

La academia tiene varios muebles donde se pueden guardar cosas, para esta primera versión
solamente se utilizarán armarios convencionales, gabinetes mágicos y baúles

Se puede guardar una cosa en la academia siempre que no esté ya guardada y haya al menos un mueble 
donde se pueda guardar:
- Un **baúl** tiene una capacidad máxima de volumen. El volumen usado es la suma de los volumenes de todas 
  las cosas guardadas en él. Puede guardar una nueva cosa siempre que tenga suficiente espacio: *El volumen
  de la cosa a guardar más el volumen ya usado no puede superar la capacidad máxima*. 
- En un **gabinete mágico** sólo se puede guardar cosas que sean mágicas, sin límites.
- En un **armario convencional** se puede guardar una cantidad máxima de elementos 
  No importa el volumen de las cosas, solo la cantidad.

*IMPORTANTE: No olvidar que no se puede guardar algo que ya está guardado!*
  
### Escenario de pruebas

**Cosas:**
-  una **pelota de fútbol**: su marca es Cuchuflito, tiene 3 de volumen, no es mágica y no es una reliquia.
-  una **escoba gastada**: su marca es Acme, tiene 4 de volumen, sí es mágica y es una reliquia.
-  una **varita mágica**: su marca es Fenix, tiene 1 de volumen, es mágica y no es una reliquia. 
-  la **pava de mate del director**: su marca es Acme, tiene 2 de volumen, no es mágica y sí es una reliquia
-  la **lampara de Aladino**: su marca es Fenix, tiene 3 de volumen ,  es mágica y  es una reliquia

**Muebles:**

La academia tiene:
- un baúl de 5 litros de volumen máximo, adentro tiene solamente la escoba gastada.
- un gabinete magico donde está guardada la varita mágica
- un armario convencional con la pelota de fútbol que puede contener hasta 2 elementos en total 
  (le queda espacio para un elemento más).

*Nota: Tener en cuenta que éste es solo un escenario posible. Podría haber otro donde haya por ejemplo, 
otro baúl más de otra capacidad, más gabinetes, etc.*

### Requerimientos:

1. **Saber si una cosa está guardada o no en la academia.**
 
   En este ejemplo la pelota, la escoba y la varita sí están guardados. 
   Mientras que la pava y la lampara no.

2. **Saber en que mueble está guardada una cosa.**
   
   En este ejemplo la escoba está en el baúl, la pelota está en el armario y la varita está en el gabinete mágico

3. **Saber si una cosa se puede guardar en la academia.**

   En este ejemplo la pava se puede guardar ya que entra en el armario.
   Pero si se configura el sistema para que el armario tenga solo 1 de capacidad, entonces 
   ya no se puede guardar porque no entra en ningún mueble.
 
   La lámpara también se puede guardar,ya que entra tanto en el baúl como en el gabinete mágico
 
   La pelota, la escoba y la varita no se pueden guardar debido a que ya están guardados
 
4. **Saber en que muebles se podría guardar una cosa.**

   En este ejemplo la pava de mate se puede guardar en el armario. 
   Mientras que la lámpara de Aladino entra tanto en el armario como en el gabinete mágico 
        
5. **Guardar algo en la academia:**
 
   Si la cosa se puede guardar en la academia entonces se busca un mueble apto y se guarda en él. 
   Tener en cuenta que si la cosa no cumple con el punto 3 (que no se puede guardar porque no hay mueble
   en que entre o porque ya estaba guardada) entonces no se está cumpliendo con la responsabilidad del mensaje!

   En este ejemplo la pava se guarda en el armario, mientras que la lámpara de aladino se guardaría en el 
   armario o en el gabinete mágico (según como esté implementado). 
   
   La escoba, la pava y la varita no se pueden guardar.

   *Tip:* Para verificar que la cosa se agrego efectivamente alcanza con verificar que está en la academia 
   usando lo resuelto en el punto 1. **No intenten** verificar en que mueble quedó.

## Parte 2:  Utilidad y precio

La **utilidad de un mueble** es un número que sirve como indicador para saber si un mueble está siendo 
bien usando o no. Se calcula como la división entre la sumatoria de la utilidad de las cosas que 
se guardan en ese mueble, sobre el precio del mueble. 

```
 sumatoria(utilidad de las cosas) / precio
```

La **utilidad de una cosa** es el volumen más 3 si es mágia más 5 si es reliquia más la utilidad que le aporta
la marca. 

```
 volumen + 3_SiEsMagica + 5_SiEsReliquita + loQueAportaLaMArca 
```
Aporta de las marcas:
   - **Acme:** Aporta la mitad del volumen de la cosa como utilidad
   - **Fenix:** Aporta 3 sí la cosa es una reliquia
   - **Cuchuflito:** No aporta nada (o lo que es lo mismo, aporta 0)


Precios:
- El precio de un **armario** se calcula como 5 por la cantidad que puede albergar
- El precio de un **baúl** se calcula como  el volumen maximo + 2
- El precio de un **gabinete** se define para cada gabinete

La **utilidad del baúl** se calcula levemente distinto que para el resto de los muebles:
Además de la fórmula dada para los muebles, se suma un extra. Ese extra es de 2 si
todas las cosas que almacena son reliquias.
```
 (sumatoria(utilidad de las cosas) / precio ) + 2_siTodasSonReliquias
```

Existen también **Baúles Mágicos**, el cual además de tener un extra de 2 en la utilidad si todas las
cosas que almacena son reliquias, también suma 1 por cada elemento mágico, pero su precio es el doble que 
un baul no mágico.

```
 (sumatoria(utilidad de las cosas) / precio_del_baul_magico ) + 2_siTodasSonReliquias + cantidadDeReliquias 
```

### Escenario de prueba.

Al mismo escenario del punto 1 se le agrega la pava al armario y la lámpara de aladino al gabinete.
El gabinete tiene 6 de precio.

Armar por fuera de la academia un baul mágico de volumen 12, con la lampara de aladino y la escoba mágica.



### Requerimientos

1. **Saber la utilidad de un mueble**
	
   - La utilidad del armario (que tiene la pelota y la pava) es:  `((3 + 0 + 0 + 0) + (2 + 0 + 5 + 1)) / (5 * 2) = 1.1`
   - La utilidad del gabinete (que tiene la varita y la lampara) es:  `((1 + 3 + 0 + 0) + (3 + 3 + 5 + 3)) / 6 = 3`
   - La utilidad del baul (que tiene la escoba) es:  `((4 + 3 + 5 + 2)  / (5 + 2)) + 2 = 4`
   - La utilidad del baul magico (que tiene la lampara y la escoba) es:  `((3 + 3 + 5 + 3) + (4 + 3 + 5 + 2) / (2*(12 + 2)) + 2 + (1 + 1) = 5`
 
2. **Obtener el conjunto de las cosas menos útiles de los muebles de la academia**.

   Es el conjunto que se forma con el elemento menos útil de cada mueble.

   En este caso sería la pelota (del armario), la varita (del gabinete) y la escoba (del baúl). Asumir
   que todos los muebles tienen al menos un elemento.

3. **Saber la marca del elemento menos util**

   Es la marca de la cosa que tiene menor utilidad del conjunto obtenido en el requerimiento anterior.
   
   En el ejemplo anterior, el conjunto de cosas menos útiles contiene a la pelota, la varita y la escoba. 
   De entre esos 3 el de menor utilidad es la pelota, cuya marca es **cuchuflito**.

4. **Remover de la academia aquellos elementos que pertenecen al conjunto de las cosas menos útiles 
(lo resuelto en el punto 2.2) y que además no son mágicas**.

   Esta acción solo la puede realizar si la academia tiene al menos 3 muebles.

   En este caso se debería remover solo la pelota. 

   Pero en un escenario en el cual la academia tenga solo el armario y el baul no debería poder realizarse.



