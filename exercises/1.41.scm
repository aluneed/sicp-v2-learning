#lang scheme

;;; exercise 1.41 ;;;

(define (double f)
    (lambda (x) (
        f (f x)
    ))
)

(define (inc x) (+ x 1))
((double inc) 1)  ;;3

(((double (double double)) inc) 5)  ;;21

#|
很容易联想到对斐波那契数列计算的指数进行优化,
当通项标号n为2的倍数时, 将其变换为每次迭代递推等价于两次斐波那契数列迭代递推的数列的第n/2项.

同时double嵌套的次数和阿克曼函数定义的一种过程有关, 也和反过来优化的次数有关
|#