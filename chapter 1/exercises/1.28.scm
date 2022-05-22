#lang scheme

;;; exercise 1.28 ;;;

#|
 a^n mod m
=(a mod m)^n mod m

 a^n mod m
=a*a^(n-1) mod m
=(a mod m)^(n-1)*a mod m

 a^n mod m
=(a^(n/2) mod m)^2 mod m

 a^(n-1) mod m
=(a mod m)^

|#

(define (fastRemainder a n m) (
    iterator a n m
))
(define (iterator a n m) (
    cond
        ((= n 0) 1)
        ((odd? n) (remainder (* a (iterator a (- n 1) m)) m))
        (else (remainder (expt (iterator a (/ n 2) m) 2) m))
))

(define (mrTest n) (
    testIter n 3
))
(define (testIter n counter) (
    cond
        ((= counter 0) #t)
        ((not (= 1 (fastRemainder (getRandom n) (- n 1) n))) #f)
        (else #t)
))
(define (getRandom n) (
    if (> n 4294967087)
        (- n (random 4294967087))
        (+ (random (- n 1)) 1)
))
