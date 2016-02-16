#lang racket

; tacha
(define (tacha l)
  (cond ((null? l) l)
        ((list? (car l))
         (cons (tacha (car l)) (tacha (cdr l))))
        (else (cons '* (tacha (cdr l))))
  )
)

; simetrico
(define (simetrico n)
  (if (zero? n)
      '()
      (list '< (simetrico  (- n 1)) '>)
  )
)

; sustituye
(define (sustituye x y l)
  (cond ((null? l) l)
        ((list? (car l))
         (cons (sustituye x y (car l)) (sustituye x y (cdr l))))
        ((equal? (car l) x)
         (cons y (sustituye x y (cdr l))))
        (else (cons (car l) (sustituye x y (cdr l))))
  )
)