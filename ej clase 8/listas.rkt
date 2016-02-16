#lang racket

; mayor
(define (mayor l)
  (m2 (cdr l) (car l))
)

(define (m2 l max)
  (cond 
    ((eq? l '())
      max)
    ((< (car l) max)
      (m2 (cdr l) max))
    (else (m2 (cdr l) (car l)))
  )
)

; secuencia
(define (secuencia n)
  (s2 n 0)
)

(define (s2 n x)
  (if (= n x) (cons n '())
      (cons x (s2 n (+ x 1)))
  )
)

; elimina
(define (elimina l lst)
  (remove* (list l) lst)
)