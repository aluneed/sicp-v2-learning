#lang scheme

;;; exercise 2.20 ;;;

(define (same-parity . numbers)
    (define (filter numbers parity)
        (cond
            ((null? numbers) numbers)
            ((even? (+ (car numbers) parity)) (cons (car numbers) (filter (cdr numbers) parity)))
            (else (filter (cdr numbers) parity))
        )
    )
    (filter numbers (if (odd? (car numbers)) 1 0))
)

(same-parity 1 2 5 3 4 5 6 7 8 9 11 7 5)

#|
parity是一个不得不传递的状态, 否则在递归的context中无法获取第一个元素的奇偶信息(不使用let或者单独define的话)  

一开始套了两层if, 改了  
代码也跟着逻辑理了一下, 判断都加到cond里了
没想到第一次跑就没有任何问题

但是我开始怀疑写出这种看似精巧但实则难读的递归函数到底有没有意义
毕竟只要在函数中再加一个参数来传递新构造的list就可以了  
如果用java的list, 这种递归写法可能还会对原始list产生影响, 导致副作用(如果将最终的空list看作java中List的引用的话)

虽然这一系列递归操作可以在同一个list上进行, 但(car numbers)的结果仍然会占用栈中的空间
|#