#lang scheme

;;; exercise 2.5 ;;;

#|
虽然这个题设看上去比较显然, 但好像不怎么容易证明

看到2^a*3^b之后, 很容易联想到哥德尔不完备定理的证明  
采用素数为底, 得到积后进行质因数分解  
顺藤摸瓜可以查到算数基本定理, 证明同见wiki
https://zh.wikipedia.org/wiki/%E7%AE%97%E6%9C%AF%E5%9F%BA%E6%9C%AC%E5%AE%9A%E7%90%86

于是题设显然得证  

剩下的问题就是写代码进行质因数分解
|#

(define (cons x y) 
    (* (expt 2 x) (expt 3 y))
)

(define (car t)
    (count2 t 0)
)
(define (cdr t)
    (count3 t 0)
)

(define (count2 t c)
    (if (odd? t)
        c
        (count2 (/ t 2) (+ c 1))
    )
)

(define (count3 t c)
    (countPrimal t 3 c)
)

(define (countPrimal num prim c)
    (if (= (remainder num prim) 0)
        (countPrimal (/ num prim) prim (+ c 1))
        c
    )
)

(define z (cons 0 3))
(car z)
(cdr z)

;;不知道奇偶判断是不是快一点, 还是保留count2了
;;另一种写法
;;虽然最开始想直接返回一个lambda, 但是由于涉及到递归调用, 还是命名了

(define (getPrimCounter prim)
    (define (primCounter num count)
        (if (= (remainder num prim) 0)
            (primCounter (/ num prim) (+ count 1))
            count
        )
    )
    primCounter
)

(define (car t)
    ((getPrimCounter 2)
        t 0
    )
)

(define (cdr t)
    ((getPrimCounter 3)
        t 0
    )
)
