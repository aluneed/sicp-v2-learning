#lang scheme

;;; exercise 2.54 ;;;

(define (equal? obj1 obj2)
    (cond
        ((null? obj1)
            (null? obj2)
        )
        ((pair? obj1)
            (if (pair? obj2)
                (and (equal? (car obj1) (car obj2)) (equal? (cdr obj1) (cdr obj2)))
                #f
            )
        )
        (else 
            (if (eq? obj1 obj2)
                #t
                #f
            )
        )
    )
)

(equal? '(this is a list) '(this is a list))
(equal? '(this is a list) '(this (is a) list))
(equal? '() '())
(equal? 'abc 'abc)
(equal? '1 1)