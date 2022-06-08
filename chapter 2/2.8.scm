#lang scheme

(define (make-interval a b) (cons a b))

(define (lower-bound t)
    (min (car t) (cdr t))
)
(define (upper-bound t)
    (max (car t) (cdr t))
)

;;; exercise 2.8 ;;;

(define (sub-interval x y)
    (make-interval 
        (- (upper-bound x) (lower-bound y))
        (- (lower-bound x) (upper-bound y))
    )
)

#| test
(define a (make-interval -3 8))
(define b (make-interval 2 13))
(sub-interval a b)
(sub-interval b a)
|#