#lang scheme

;;; exercise 1.32 ;;;

(define (sum term a next b) (
    accumulate + 0 term a next b
))
(define (product term a next b) (
    accumulate * 1 term a next b
))

;;;  just for test  ;;;
(define (next a) (+ a 1))
(define (term x) x)

;; a)
(define (accumulate combiner nullValue term a next b) (
    ;;iterator combiner term b counter dx nullValue
    iterator combiner term next a b nullValue
))

#|
(define (iterator combiner f x counter dx result) (
    if (= counter 0)
        result
        (iterator combiner f (- x dx) (- counter 1) dx (combiner result (f x)))
))
|#
(define (iterator combiner f next a b result) (
    if (> a b)
        result
        (iterator combiner f next (next a) b (combiner result (f a)))
))

#|  不写iterator的写法
(define (accumulate combiner nullValue term a next b) (
    if (> a b)
        nullValue
        accumulate combiner (combiner nullValue (term a)) term (next a) next b
))
|#

;; b)
(define (accumulate combiner nullValue term a next b) (
    if (> a b)
        nullValue
        (combiner (term a) (accumulate combiner nullValue term (next a) next b))
))
