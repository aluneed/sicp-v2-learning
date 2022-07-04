#lang scheme

;;; exercise 2.21 ;;;

(define (square-list items)
    (if (null? items)
        '()
        (cons (sqr (car items)) (square-list (cdr items)))
    )
)
(define (square-list items)
    (map (lambda (i) (sqr i)) items)
)
(square-list '(1 2 3 4 5))

;;平方 (sqr x)
;;(map function items)也已经内置了