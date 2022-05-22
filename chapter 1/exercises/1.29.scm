#lang scheme

;;; exercise 1.29 ;;;

(define (simpsonRule f a b n) (
    *
        (- (iterator f a n 0.0 (/ (- b a) n)) a b)
        (/ (- b a) n)
        (/ 3.0)
))
(define (iterator f a n sum h) (
    if (= n 0)
        sum
        (iterator f a (- n 1) (+ sum (* (f (+ a (* h n))) (ratio n))) h)
))
(define (ratio n) (
    if (odd? n)
        4
        2
))

(define (cube x) (* x x x))

(simpsonRule cube 0 1 100)
(simpsonRule cube 0 1 1000)

#|
太感动了
这次写完居然只有一个bug
最开始写f (+ a (* h n))的时候忘记在f外面加括号了
|#

;;写到1.31之后, 优化了一下迭代计算过程
;;更重要的是, 更改了一些变量名称, 看起来非常符合数学语言
(define (simpsonRule f a b n) (
    *
        (- (iterator f b n 0.0 (/ (- b a) n)) a b)
        (/ (- b a) n)
        (/ 3.0)
))
(define (iterator f x n result dx) (
    if (= n 0)
        sum
        (iterator f (- x dx) (- n 1) (+ result (* (f x) (ratio n))) dx)
))
(define (ratio n) (
    if (odd? n)
        4
        2
))
(define (cube x) (* x x x))
(simpsonRule cube 0 1 100)
(simpsonRule cube 0 1 1000)

#|
为什么用n=0控制迭代终止而非x=a控制迭代终止?
因为可以少传一个参数a
为什么用n=0控制迭代终止, 从原始的n开始递减, 而非从0递增到原始的n?
同样为了少传一个参数
在其他语言中则可以节省一个外部变量
作为函数参数传递时, 天然就是immutable的变量(除非手贱在递归调用前修改了参数), 不会被外部环境所影响

迭代计数从n递减至0在这种递归过程中是一种普遍现象
|#