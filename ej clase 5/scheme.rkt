#lang racket

;problema 1
(define (rectangulo a b calculo)
    (cond
        ((eq? calculo 'perimetro)
            (* (+ a b) 2))
        ((eq? calculo 'diagonal)
            (sqrt (+ (sqr a) (sqr b))))
        (else (* a b))
    )
)

;problema 2
(define (mediana a b c)
    (cond
        ((or (and (<= b a) (<= a c)) (and (>= b a) (>= a c)))
            a)
        ((or (and (<= a b) (<= b c)) (and (>= a b) (>= b c)))
            b)
        ((or (and (<= a c) (<= c b)) (and (>= a c) (>= c b)))
            c)
    )
)

;problema 3
(define (masomenos a b c d)
    (cond
       ((and (positive? a) (positive? b) (positive? c)) "positivos")
       ((and (positive? a) (positive? b) (positive? d)) "positivos")
       ((and (positive? a) (positive? c) (positive? d)) "positivos")
       ((and (positive? b) (positive? c) (positive? d)) "positivos")
       ((and (positive? a) (zero? b) (negative? c) (positive? d)) "positivos")
       ((and (negative? a) (negative? b) (negative? c)) "negativos")
       ((and (negative? a) (negative? b) (negative? d)) "negativos")
       ((and (negative? a) (negative? c) (negative? d)) "negativos")
       ((and (negative? b) (negative? c) (negative? d)) "negativos")
       ((and (negative? a) (zero? b) (positive? c) (negative? d)) "negativos")
       ((and (zero? a) (zero? b) (positive? c) (negative? d)) "empate")
       ((and (zero? a) (zero? b) (negative? c) (positive? d)) "empate")
       ((and (positive? a) (negative? b) (zero? c) (zero? d)) "empate")
       ((and (negative? a) (positive? b) (zero? c) (zero? d)) "empate")
       ((and (positive? a) (zero? b) (negative? c) (zero? d)) "empate")
       ((and (negative? a) (zero? b) (positive? c) (zero? d)) "empate")
       ((and (positive? a) (zero? b) (zero? c) (negative? d)) "empate")
       ((and (negative? a) (zero? b) (zero? c) (positive? d)) "empate"
       )
)