#lang scheme

;;; exercise 2.4 ;;;

(define (cons x y)
    (lambda (m) (m x y))
)

(define (car z)
    (z
        (lambda (p q) p)
    )
)

(define (cdr z)
    (z
        (lambda (p q) p)
    )
)

#|
对`(car (cons x y))`进行代换

-> (car (lambda (m) (m x y)))
-> ((lambda (m) (m x y)) (lambda (p q) p))
-> ((lambda (p q) p) x y)
-> x

通过这些代换验证之后, cdr的写法比较显然  
当然在验证这一点之前就可以由对称性定义cdr的过程

这种写法比2.1.3中的写法更加简洁, 而且具有对称性  
缺点则是不太容易想出来

从语义上来看
cons构造了一个匿名过程, 这个过程接收一个新的过程m作为参数  
(m x y)需要干什么就比较清楚了 - 将一个过程代入m之后, 选出x或y
car和cdr则分别带入不同的过程m, 实现了对x或y的选择

|#