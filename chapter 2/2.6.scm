#lang scheme

;;; exercise 2.6 ;;;

;;一眼看上去就感觉可能和数字逻辑有关

(define zero 
    (lambda (f) 
        (lambda (x) x)
    )
)

(define (add-1 n)
    (lambda (f)
        (lambda (x) (f ((n f) x)))
    )
)

(define (add-1 n)
    (lambda (f) (lambda (x) (f ((n f) x))))
)

#|
给出了0和加一的定义, 又要求实现1, 2和+的定义, 可能要实现一个加法器?  

下面的函数均指过程

zero是这样一个函数:
它接收任意f(可能是值也可能是函数)
然后返回一个x -> x的映射

add-1是这样一个函数: 
它接收一个代表值的函数n, 返回一个新的函数, 设这个新的函数名称为n+1
那么n+1是这样一个函数: 
它接收一个函数f, 返回一个x -> (f ((n f) x))的映射  
这个映射通过n来处理函数f, 再对x应用这个函数, 最后对f应用这个结果  

套娃套得太多了, 在语义上很难解释细节
但是从题目倒推, add-1应该在输入函数n后返回一个能够代表n+1的函数  
|#

;;题目大体上可以归结为, 已知函数zero, 以及递推关系add-1
;;求函数通项, 以及对函数作用的一个过程+
;;先尝试一下通过代换定义one和two

#|
(add-1 zero)
(lambda (f) (lambda (x) (f ((zero f) x))))
(lambda (f) (lambda (x) (f ((lambda (x) x) x))))
(lambda (f) (lambda (x) (f x)))  ;;看起来就像柯里化后的函数 f -> x  -> (f x)
|#

(define one
    (lambda (f) (lambda (x) (f x)))
)

#|
(add-1 one)
(lambda (f) (lambda (x) (f ((one f) x))))
(lambda (f) (lambda (x) (f ((lamdba (x) (f x)) x))))
(lambda (f) (lambda (x) (f (f x))))
到这里规律比较明晰了, f 被当成了算子
然而知道这一点也无法直接在代码中写出通项
这很类似于2.1.3小节, 以及1.37练习, 但是更加纯粹, 因为完全没有数值存在  
|#
(define two
    (lambda (f) (lambda (x) (f (f x))))
)

;;要构造一个同构的函数, 显然应该还是返回一个(lambda (f) ())
;;参考add-1的定义可以猜测, (n f)会得到一个和n关联的算子, 也就是重复n次f
;;单纯的加1则是在外层加一个(f)作为算子
(define (plus n1 n2) 
    (lambda (f) (lambda (x) ((n2 f) ((n1 f) x))))
)

;;n1 n2的顺序看上去并不重要  
;;虽然写出plus时没有进行严格证明, 但这个结果很符合直觉
;;只要证明(n f)的结果等价于n个f嵌套即可
