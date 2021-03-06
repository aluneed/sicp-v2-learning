#lang scheme

;;; exercise 1.11 ;;;

(define (recFn n) (
    if (< n 3)
        n
        (+ (recFn (- n 1)) (* (recFn (- n 2)) 2) (* (recFn (- n 3)) 3))
))

(define (itrFn n) (
    iterator 2 1 0 n
))
(define (iterator p1 p2 p3 n) (
    if (< n 3)
        p1
        (iterator
            (+ p1 (* 2 p2) (* 3 p3))
            p1
            p2
            (- n 1)
        )
))

#|
写完这段迭代计算的代码, 才算是深深体会到了同样是递归过程, 迭代计算和递归计算有很大的不同

先说说和常规语言的不同
fp的迭代计算过程中
并不会用一个或多个跨越多个loop的变量去保存迭代计算的中间结果
而是直接在对自身进行调用时作为参数传入(包括每次循环的中间结果和迭代计数器)

这是两者的差异, 同样是迭代计算的相同之处却难以寻找
仔细思索两种写法的共同点之后
我发现这种递归写法的迭代计算过程
本质上和循环是一样的
那就是goto!

flag iterator | (p1, p2, p3, n)
    if(n < 3)
        return p1
    else
        goto iterator | (p1+2*p2+3*p3, p1, p2, (n - 1))

循环和递归调用, 本质上都是带上参数goto已经定义好的iterator
差别无非在于如何带上参数

素晴らしいです、全てを理解していきます!

另外一点
用递归的写法去写迭代计算过程, 代码的语义是很难理解的
并不是循环或者迭代或者goto的过程难以理解
而是这种迭代计算以递归的形式呈现, 却不能以递归的语义去解释

给一个递归的函数输入初始值, 本身就意义不明
不断递减的n对应的却是不断逼近所求值的返回值
计算过程和一眼看上去语义上描述的过程非常割裂, 让人不舒服

---

1.16中有了新的发现

|#