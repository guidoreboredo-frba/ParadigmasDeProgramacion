# Primeros Ejercicios Funcional

1) Definir la función calcular, que recibe una tupla de 2 elementos, y devuelve una nueva tupla según las siguientes reglas:
   - si el primer elemento es par lo duplica; si no lo deja como está
   - si el segundo elemento es impar le suma 1; si no deja como está
>calcular’ (4,5)
(8,6)

2) Definir las funciones boolenas estándar. Sin usar las funciones predefinidas.
2.1) Definir la función and’
2.2) Definir la función or’.

3) Definir la función notaMaxima que dado un alumno devuelva la máxima nota del alumno. (Nota resolverlo sin guardas).

type Nota = Integer
type Alumno = (String, Nota, Nota, Nota)

4) Definir la función cuadruple reutilizando la función doble. 
 
5) Definir la función esMayorA, que verifique si el doble del siguiente de la suma entre 2 y un número es mayor a 10. 

6) Dar expresiones lambda que sean equivalentes a las siguientes expresiones:
triple
siguiente
suma
sumarDos

7)  Dada las siguientes definiciones:
7.1) apply f x = f x
¿ A qué se reduce la siguiente expresión ?.
> apply fst  (const 5 7, 4)
 
7.2) twice f x = (f . f) x
¿ A qué se reduce la siguiente expresión ?.
>twice (`div` 2) 12
