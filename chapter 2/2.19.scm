#lang scheme

;;; exercise 2.19 ;;;  吐了, 题目就好长

;;在之前就了解到换钱问题是可以通过生成函数去解决的  

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (except-first-denomination values)
    (cdr values)
)
(define (first-denomination values)
    (car values)
)
(define (no-more? values)
    (null? values)
)

(define (cc amount coin-values)
    (cond
        ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
            (+  
                (cc amount (except-first-denomination coin-values))
                (cc (- amount (first-denomination coin-values)) coin-values)
            )
        )
    )
)

(cc 100 us-coins)

#|
不会影响操作, 除非列表在运行过程中排序发生了改变  
cc中对coin-values的操作都是具有对称性的, 不会受list中元素顺序影响
|#