#lang scheme

;;; exercise 1.35 ;;;

#|
有点没明白题意
1.2.2已经给出了ø满足了x^2=x+1, 那不就是f(x)=1/x+1=x
|#

(define (pn? x) (/ x (abs x)))
(define (his f a b precision) (
    iterHIS f a b precision (pn? (f a)) (pn? (f b)) 0
))
(define (iterHIS f a b precision pnA pnB lr) (
    let ((average (/ (+ b a) 2.0))) (
        cond
            ((< (abs (- b a)) precision) 
                (if (= lr pnA) a b)
            )
            ((> (* (f average) pnA) 0) (iterHIS f average b precision pnA pnB pnA))
            ((> (* (f average) pnB) 0) (iterHIS f a average precision pnA pnB pnB))
            (else average)
    )
))

(define (fixedPoint f a b precision) (
    his (lambda (x) (- (f x) x)) a b precision
))
(fixedPoint (lambda (x) (+ 1 (/ x))) 1.0 2.0 0.00000001)

#|
(define (fixedPoint f x tolerance) (
    if (< (abs (-  (f x) x)) tolerance)
        x
        (fixedPoint f (/ (+ (f x) x) 2) tolerance)
))
(fixedPoint (lambda (x) (+ 1 (/ x))) 1.0 0.00000001)
|#