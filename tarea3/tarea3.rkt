#lang racket

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

