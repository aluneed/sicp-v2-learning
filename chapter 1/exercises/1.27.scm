#lang scheme

;;; exercise 1.27 ;;;

(define (checkCarmichael n)
    (display n)
    (newline)
    (display (fermatTest n))
    (newline)
    (display "smallestDivisor: ")
    (smallestDivisor n)
)

;;; 
(define (smallestDivisor x) (
    divisorIter 3 x
))
(define (divisorIter n x) (
    cond
        ((> (* n n) x) x)
        ((= (remainder x n) 0) n)
        (else (divisorIter (+ n 2) x))
))

;;;

(define (fermatTest n) (
    randomIter n 3
))
(define (randomIter n counter) (
    cond
    ((= counter 0) #t)
    ((checkPrime (getRandom n) n) (randomIter n (- counter 1)))
    (else #f)
))
(define (getRandom n) (
    if (> n 4294967087)
        (- n (random 4294967087))
        (+ 1 (random (- n 1)))
))

(define (checkPrime a n) (
    = (fastRemainder a n) a
))
(define (fastRemainder a n) (
    iterator a n n
))
(define (iterator a n m) (
    cond 
        ((= n 0) 1)
        ((odd? n) (remainder (* a (iterator a (- n 1) m)) m))
        (else (remainder (expt (iterator a (/ n 2) m) 2) m))
))

;;;
(checkCarmichael 561)
(checkCarmichael 1105)
(checkCarmichael 1729)
(checkCarmichael 2465)
(checkCarmichael 2821)
(checkCarmichael 6601)
