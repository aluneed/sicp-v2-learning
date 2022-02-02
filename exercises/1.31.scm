#lang scheme

;;; exercise 1.31 ;;;

;;a)

(define (iterator f x n result dx) (
    if (= n 0)
        result
        (iterator f (- x dx) (- n 1) (* result (f x)) dx)
))

#|
显然
f(1) = 1-1/3
f(2) = 1+1/3
f(3) = 1-1/5
f(4) = 1+1/5
...
f(n) = 1 + (-1)^n * (1 / (n + 1.5 + 0.5(-1)^(n-1)))
考虑到计算效率, (-1)的幂直接通过奇偶性判断
|#

(define (f x) (
    if (odd? x)
        (- 1 (/ 1 (+ (+ 1 x) 1)))
        (+ 1 (/ 1 (- (+ 2 x) 1)))
))

(define (product f a b n) (
    iterator f b n 1.0 (/ (- b a) n)
))

(product f 0 10000 10000)  ;; >0.7854374264344909  感觉收敛挺慢的

;;b)

(define (recProduct f a b) (
    if (= a b)
        1.0
        (* (f a) (recProduct f (+ a 1) b))
))
(recProduct f 1 10000)