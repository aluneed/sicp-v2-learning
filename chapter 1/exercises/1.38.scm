#lang scheme

;;; exercise 1.38 ;;;
(define (contFrac n0 d0 k0)
    (define (iter n d k result) (
        if (= k 0)
            result
            (iter n d (- k 1) (/ (n k) (+ result (d k))))
    ))
    (iter n0 d0 k0 0.0)
)

(define (d x) (
    if (= (remainder x 3) 2)
        (/ (* 2 (+ x 1)) 3)
        1
))
(+ 2 (contFrac (lambda (i) 1.0) d 50))  ;;2.7182818284590455
