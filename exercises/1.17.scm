#lang scheme

;;; exercise 1.17 ;;;

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

#|
妹啥好说的
需要注意的是如果重新定义了(* a b), 在(double x)中用到的*也会变成新的定义
在练习1.9中出现过类似的错误, 因此这次很容易避免
|#

;;看了练习1.18后, 我怀疑这里需要写一段拥有递归计算过程的代码

(define (recMulti a b) (
    cond
        ((= b 1) a)
        ((odd? b) (+ (recMulti a (- b 1)) a))
        (else (double (recMulti a (halve b))))
))
