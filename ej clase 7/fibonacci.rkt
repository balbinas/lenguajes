#lang racket

; geometrica
(define (geometrica n)
  (if (= n 0) 1
      (+ (/ 1 (expt 2 n)) (geometrica (- n 1)))
  )
)
         

; subebaja
(define (subebaja n)
  n
)

; fibonacci
(define (fibo n)
  (if (<= n 2) 1
      (+ (fibo (- n 1)) (fibo (- n 2)))
  )
)

; fibonacci terminal
(define (fibot n)
  (f-aux (- n 1) 1 0)
)

(define (f-aux n a b)
  (if (zero? n) a
      (f-aux (- n 1) (+ a b) a)
  )
)