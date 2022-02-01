#lang scheme

;;; exercise 1.21 ;;;

;; x should be odd
(define (smallestDivisor x) (
    iterator 3 x
))

(define (iterator n x) (
    cond
        ((> (* n n) x) x)
        ((= (remainder x n) 0) n)
        (else (iterator (+ n 2) x))
))

(smallestDivisor 199)  ;;199
(smallestDivisor 1999)  ;;1999
(smallestDivisor 19999)  ;;7
(smallestDivisor 10000000000036)  ;;boom