#lang scheme

(define (accumulate accumulator initial sequence)
    (if (null? sequence)
        initial
        (accumulator
            (car sequence)
            (accumulate accumulator initial (cdr sequence))
        )
    )
)
(define (fold-left op initial sequence)
    (define (iter result rest)
        (if (null? rest)
            result
            (iter (op result (car rest))
                (cdr rest)
            )
        )
    )
    (iter initial sequence)
)
(define fold-right accumulate)

;;; exercise 2.39 ;;;

(define (reverse sequence)
    (fold-right
        (lambda (value accumulated)
            (append accumulated (list value))
        )
        '() sequence
    )
)
(define (reverse sequence)
    (fold-left
        (lambda (accumulated value)
            (cons value accumulated)
        )
        '() sequence
    )
)
(reverse '(1 2 3 4 5))

;;需要注意书上给的fold-left中  
;;accumulated和value的参数顺序和fold-right相反  
;;需要依此调整lambda表达式中的accumulated和value的顺序  
