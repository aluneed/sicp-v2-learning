#lang scheme

;;; exercise 2.31 ;;;

(define (tree-map function tree)
    (cond
        ((null? tree) '())
        ((pair? tree)
            (cons 
                (tree-map function (car tree))
                (tree-map function (cdr tree))
            )
        )
        (else (function tree))
    )
)

(define (tree-map function tree)
    (map
        (lambda (sub-tree)
            (cond
                ((null? sub-tree) '())
                ((pair? sub-tree) (tree-map function sub-tree))
                (else (function sub-tree))
            )
        )
        tree
    )
)

(define x
    (list 1
        (list
            2 
            (list 3 4)
            5
            (list 6 7)
        )
    )
)
(define (square-tree tree) (tree-map sqr tree))
(square-tree x)