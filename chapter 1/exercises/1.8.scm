#lang scheme

;;; exercise 1.8 ;;;

(define (cbr x) (
    cbrIterator 1.0 x
))

(define (cbrIterator guess x) (
    if (goodEnough guess x)
        guess
        (cbrIterator (improve guess x) x)
))

(define (goodEnough guess x) (
    < (abs (- (/ guess (improve guess x)) 1)) 0.00000000000000000000001
))

(define (cb x) (* x x x))

(define (improve guess x) (
    / (+ (/ x (sqr guess)) (* 2 guess)) 3
))

(define (sqr x) (
    * x x
))
