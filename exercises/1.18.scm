#lang scheme

;;; exercise 1.18 ;;;

(define (double x) (* x 2))
(define (halve x) (/ x 2))

(define (multi a b) (
    iterator 0 a b
))

(define (iterator t a b) (
    cond
        ((= b 0) t)
        ((odd? b) (iterator (+ t a) a (- b 1)))  ;;a'*b'=a'*(b'-1)+a'
        (else (iterator t (double a) (halve b)))  ;;a'*b'=(2*a')*(b'/2)
))
