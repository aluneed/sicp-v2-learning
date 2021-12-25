#lang scheme

;;; exercise 1.3 ;;;

(define (min x y)
    (if (< x y) x y)
)
(define (f a b c)
    (- (+ a b c) (min (min a b) c))
)