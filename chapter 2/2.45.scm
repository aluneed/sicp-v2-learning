#lang scheme

;;; exercise 2.45 ;;;

(define (split-builder f1 f2)
    (define (split painter n)
        (let ((smaller (split painter (- n 1))))
            (if (= n 0)
                painter
                (f1 (f2 smaller smaller))
            )
        )
    )
    split
)
