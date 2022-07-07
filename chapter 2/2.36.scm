#lang scheme

;;; exercise 2.36 ;;;

;;看着就像list之间的相互运算  

(define (accumulate-n op init seqs)
    (if (null? car seqs)
        '()
        (cons
            (accumulate op init)
            (accumulate-n op init (cdr seqs))
        )
    )
)
