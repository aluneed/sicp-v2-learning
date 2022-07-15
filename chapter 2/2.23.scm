#lang scheme

;;; exercise 2.23 ;;;

(define (for-each consumer items)
    (cond 
        ((not (null? items))
            (consumer (car items))
            (for-each consumer (cdr items))
        )
    )
)
(for-each (lambda (x) (newline) (display x)) '(57 321 88))

;;试了老半天if最后发现行不通  
;;cond不需要返回值, 参考章节1.1.6