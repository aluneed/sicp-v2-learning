#lang scheme

;;; exercise 1.37 ;;;

#|
f(k, N) = Nk / (Dk + f(k+1,N))
看起来截断后的部分比截断前的部分更容易表示
也就是说, 这个表达式的计算先后顺序决定了, 总是从连分式的内层开始
|#

(define (contFracR n d k)
    (define (recu n d k count) (
        if (= k count)
            (/ (n k) (d k))
            (/ (n k) (+ (recu n d k (+ count 1)) (d k)))
    ))
    (recu n d k 1)
)
(contFracR (lambda (i) 1.0) (lambda (i) 1.0) 50)
#|
想了很久都没想出不需要count的写法
感觉有的地方需要额外参数, 有的地方不需要, 需要总结一下
todo
|#



#|
(define (contFracI n d k) (
    if (= k 1)
        (/ (n k) (d k))
        ;;(contFracI n (lambda (x) (+ (d x) (/ (n k) (d k)))) (- k 1))  ;;这种做法存在问题, 无法获取到原始的d=(lambda (i) 1.0)
        ;;迭代计算过程并不能通过改变函数本身来减少参数列表的数量, 除非函数d是一个已知的常量, 可以直接写进代码中
))

(lambda
    (x)
    (+
        (d x)  ;;这里的d已经不是(lambda (i) 1.0)
        (/ (n k) (d k))
    )
)
|#

(define (contFracI n d k)
    (define (iter n d k d0) (
        if (= k 1)
            (/ (n k) (d k))
            (iter n (lambda (x) (+ (d0 x) (/ (n k) (d k)))) (- k 1) d0)
    ))
    (iter n d k d)
)
(contFracI (lambda (i) 1.0) (lambda (i) 1.0) 50)
;;or
(define (contFracI n0 d0 k0)
    (define (iter n d k) (  ;;实际上n也没有必要再传入, 可以直接引用n0
        if (= k 1)
            (/ (n k) (d k))
            (iter n (lambda (x) (+ (d0 x) (/ (n k) (d k)))) (- k 1))
    ))
    (iter n0 d0 k0)
)
(contFracI (lambda (i) 1.0) (lambda (i) 1.0) 50)
#|
d0要么作为参数被传递, 要么在内部作用域里被引用
这里尝试了一种比较tricky的写法, 迭代时改变函数d, 而不是改变某个存储结果的变量或者被不断传递的参数
通常的做法也比较简单
(define (iter n d k result) (
    if (= k 0)
        result
        (iter n d (- k 1) (/ (n k) (+ result (d k))))
))
;;init (iter n d k result)
|#