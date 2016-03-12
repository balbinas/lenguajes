#lang racket
(require math/number-theory)

(define arbol '(a (f (g)) (c) (b (d) (e))))

; 1a. multirama?
; Determina si una lista representa un árbol multi- rama.
(define multirama?
  (lambda (tree)
    (cond ((null? tree) false)
          ((atom? tree) false)
          ((< 2 (numRamas (cdr tree))) true)
          ((eq? 2 (numRamas (cdr tree)))
             (or (multirama? (cddr tree)) (multirama? (cdddr tree)))
          )
          ((eq? 1 (numRamas (cdr tree)))
             (multirama? (cdr tree))
          )
          (else false)
    )
  )
)

(define numRamas
  (lambda (tree)
    (if (null? tree) 0
        (+ 1 (numRamas (cdr tree)))
    )
  )
)

(define atom? (lambda (x) (not (list? x))))


; 1b. nnodos
; Cuenta y regresa la cantidad de nodos de un árbol multi-rama
(define nnodos
  (lambda (tree)
    (cond ((null? tree) 0)
          ((atom? tree) 1)
          (else (+ (nnodos (car tree)) (nnodos (cdr tree))))
    )
  )
)


; 1c. simplifica
; Reduce la representación de un árbol multi-rama representando sus hojas con sus valores.
(define simplifica
  (lambda (tree)
    (cond ((null? tree) '())
          ((atom? tree) tree)
          ((atom? (car tree))
           (if (not (null? (cdr tree)))
               (cons (car tree) (simplifica (cdr tree)))
               (car tree)
           )
          )
          ((eq? 1 (nnodos (car tree))) (cons (caar tree) (simplifica (cdr tree))))
          (else (cons (simplifica (car tree)) (simplifica (cdr tree))))
    )
  )
)


; 1d. b->m
; Convierte un árbol binario en un árbol multi-rama.
(define b->m
  (lambda (tree)
    (cond ((atom? tree) tree)
          ((null? tree) null)
          ((not (null? (car tree)))
              (cond ((null? (cadr tree))
                        (if (null? (caddr tree))
                            (list (car tree))
                            (append (list (car tree)) (list (b->m (caddr tree))))
                        )
                     )
                     ((null? (caddr tree)) (append (list (car tree)) (list (b->m (cadr tree)))))
                     (else (append (list (car tree)) (list (b->m (cadr tree)) (b->m (caddr tree)))))
              )
          )
          (else null)
    )
  )
)