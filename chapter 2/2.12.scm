#lang scheme

(define (make-interval a b) (cons a b))

(define (lower-bound t)
    (min (car t) (cdr t))
)
(define (upper-bound t)
    (max (car t) (cdr t))
)

;;;;;;

(define (make-center-width c w)
    (make-interval (- c w) (+ c w))
)

(define (center i)
    (/ (+ (lower-bound i) (upper-bound i)) 2.0)
)

(define (width i)
    (/ (- (upper-bound i) (lower-bound i)) 2.0)
)

;;; exercise 2.12 ;;;

(define (make-center-percent c p)
    (make-center-width c (/ (* c p) 100.0))
)

(define (percent i)
    (* (/ (width i) (center i)) 100.0)
)

(define t (make-center-percent 100 5.8))

(center t)
(width t)

#|
100.0
5.799999999999997
寄了, 精度丢失了  
加减法都可能造成  
(+ 105.8 94.1) -> 199.89999999999998
|#