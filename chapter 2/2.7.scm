#lang scheme

;;; exercise 2.7 ;;;

(define (make-interval a b) (cons a b))

(define (lower-bound t)
    (min (car t) (cdr t))
)
(define (upper-bound t)
    (max (car t) (cdr t))
)

#| test
(define z (make-interval 2 1))
(lower-bound z)
(upper-bound z)
|#