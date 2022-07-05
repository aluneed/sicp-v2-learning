#lang scheme

;;; exercise 2.30 ;;;

;;虽然可以直接定义一个遍历树的过程, 然后在这个过程中进行一些处理, 但还是写一下当做练习了

(define (square-tree tree)
    (cond
        ((null? tree) '())
        ((pair? tree)
            (cons
                (square-tree (car tree))
                (square-tree (cdr tree))
            )
        )
        (else (sqr tree))
    )
)
;;由于不需要倒排, 直接用cons就行, 写起来没有练习2.27那么容易出错

(define (square-tree tree) 
    (map  ;;map是内置的list处理过程
        (lambda (sub-tree)
            (cond
                ((null? sub-tree) '())
                ((pair? sub-tree) (square-tree sub-tree))
                (else (sqr sub-tree))
            )
        )
        tree
    )
)

(square-tree
    (list 1
        (list
            2 
            (list 3 4)
            5
            (list 6 7)
        )
    )
)