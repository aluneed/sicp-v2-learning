#lang scheme

;;; exercise 2.34 ;;;

;;horner求值, 多项式求值计算最优算法

; (define (horner-eval x coefficient-sequence)
;     (if (null? coefficient-sequence)
;         0
;         (+
;             (car coefficient-sequence)
;             (* x (horner-eval x (cdr coefficient-sequence)))
;         )
;     )
; )


(define (accumulate accumulator initial sequence)
    (if (null? sequence)
        initial
        (accumulator
            (car sequence)
            (accumulate accumulator initial (cdr sequence))
        )
    )
)

(define (horner-eval x coefficient-sequence)
    (accumulate
        (lambda (value accumulated) 
            (+
                (* x accumulated)
                value
            )
        )
        0
        coefficient-sequence
    )
)

;;1+3x+5x^3 + x^5)|x=2
(horner-eval 2 (list 1 3 0 5 0 1))