#lang racket
(require math/number-theory)

(define % modulo)

; factor?
; Predicado NO recursivo que determina si alguno de sus cuatro argumentos
; divide exactamente al menos a dos de los otros tres argumentos enteros positivos.
(define (factor? a b c d)
  (or (faux? a b c d) (or (faux? b a c d) (or (faux? c a b d) (faux? d a b c))))
)

(define (faux? a x y z)
  (if (eq? (% x a) 0)
      (or (eq? (% y a) 0) (eq? (% z a) 0))
      (and (eq? (% y a) 0) (eq? (% z a) 0))
  )
)

; digpar?
; Función recursiva que determina si alguno de los dígitos de su argumento entero es par.
(define (digpar? n)
  (if (eq? (% n 2) 0)
      true
      (if (> n 10)
          (digpar? (/ (- n (% n 10)) 10))
          false
      )
  )
)

; seno
; Función recursiva que regresa el seno de su primer argumento x mediante los
; n primeros términos de la serie de Taylor
(define (seno x n)
  (if (eq? n 0)
      1
      (+ (taylor x n) (seno x (- n 1)))
  )
)
(define (taylor x n)
  (* (expt -1 n) (/ (expt x (+ n n 1)) (factorial (+ n n 1)) ))
)

; multiplos
; Función recursiva multiplos que calcula la suma de los primeros N múltiplos de
; un número entero positivo.
(define (multiplos x n)
  (if (eq? n 1)
      x
      (+ (* x n) (multiplos x (- n 1)))
  )
)

; bitxor
; Función recursiva que calcula el xor lógico entre bits dados como elementos de
; 2 listas dadas dos listas son del mismo tamaño.
(define (bitxor)
  
)

; octal
; Función recursiva que regresa una lista de numeros y letras que representa la
; codificación octal del argumento entero que representa un número en binario.
(define (octal l)
  
)

; list->num
; Función recursiva list->num que convierte su argumento dado como una lista de
; dígitos en un número entero no negativo.
(define (list->num l)
  (if (eq? (cdr l) '())
      (car l)
      (+ (* (expt 10 (- (length l) 1)) (car l)) (list->num (cdr l)))
 )
)