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

; 2e. intercambia
; intercambia los renglones de una matriz dependiendo de los argumentos de la funcion
(define (intercambia idx1 idx2 l)
  (let* ([x (list-ref l (- idx1 1))]) 
  (list-set (list-set l (- idx2 1) x) (- idx1 1) (list-ref l (- idx2 1)))))

; 2f. diagonal
; regresa la diagonal principal de la matriz.
(define (diagonal m)
  (cond
    ((null? m) '())
    (else (cons (caar m) (diagonal (colr (cdr m)))))))

; 2g . multiply matrix
; Multiplica matrices que si se pueden multiplicar.
(define (multmat m1 m2)
  (cond
    ((null? m1) '())
    ((null? (car m1)) '())
    (else (cons (removelast (vecmult (car m1) m2)) (multmat (cdr m1) m2)))))

; Multiplica 1 renglon por una matriz.
(define (vecmult v m)
  (cond
    ((null? m) '())
    (else (cons (dotprod v (col m)) (vecmult v (colr m))))))

(define (dotprod v1 v2)
  (cond
    ((null? v1) 0)
    ((null? v2) 0)
    (else (+ (* (car v1) (car v2)) (dotprod (cdr v1) (cdr v2))))))

; regresa la primera columna de una matriz.
(define (col m)
  (cond
    ((null? m) '())
    ((null? (car m)) '())
    (else (cons (car (car m)) (col (rest m))))))

; regresa el resto de la matriz al quitarle la primera columna.
(define (colr m)
  (cond
    ((null? m) '())
    ((null? (car m)) '())
    (else (cons (rest (car m)) (colr (rest m))))))

; elimina el último elemento de una lista.
(define (removelast l)
    (if (null? (cdr l))
        '()
        (cons (car l) (removelast (cdr l)))))


;3 Problema sobre funcion de orden superior
;
(define g
    '((A ((B 2) (D 10)))
      (B ((C 9) (E 5)))
      (C ((A 12) (D 6)))
      (D ((E 7)))
      (E ((C 3)))
))

;3a listar "nodos-destino" que tienen a N como nodo origen directo
(define (nodos-destino grafo origen)
    (map car
    (list-ref  
        (car (filter (lambda (renglon) (equal? (car renglon) origen)) grafo))
    1))
)

;3b listar "nodos-origen" que tienen a N como de destino
(define (nodos-origen grafo destino)
    (map car (filter (lambda (renglon) 
        (member destino (map car (car (cdr renglon))))
    ) grafo))
)

;3c listar nodos restantes de "elimina-arco"
(define (elimina-arco grafo nodo arco)
    (map 
        (lambda (nombre-nodo lista-nodos)
            (if (equal? nodo nombre-nodo)
                (if (member arco (map car (car lista-nodos)))
                    (list nombre-nodo 
                        (filter 
                            (lambda (ruta) (not (equal? arco (car ruta))))
                            (car lista-nodos)))
                    (list nombre-nodo (car lista-nodos))
                )
                (list nombre-nodo (car lista-nodos))
            )
        )
        (map car grafo) 
        (map cdr grafo)
    )
)