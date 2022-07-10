#lang scheme

(define (accumulate accumulator initial sequence)
    (if (null? sequence)
        initial
        (accumulator
            (car sequence)
            (accumulate accumulator initial (cdr sequence))
        )
    )
)

;;; exercise 2.36 ;;;

;;看着就像list之间的相互运算  

;;两种方式: 遍历每个子list的第n个元素, 相加之后进行cons组合; 遍历每个子list, 直接累加到新的list上
;;由于init为0而非'(), 因此只能采用第一种方式
;;accumulate已经被封装好了, 不应该再去考虑op和init, 而应该考虑如何构造出需要的sequence
n;;(accumulate op init sequence)中op和init都已经给定, init还是叶子元素的类型  

(define (accumulate-n op init seqs)
    (if (null? (car seqs))
        '()
        (cons
            (accumulate op init
                (map
                    (lambda (element-list) (car element-list))
                    seqs
                )
                ;;(accumulate (lambda (value accumulated) (cons (car value) aacumulated)) '() seqs)
            )
            (accumulate-n op init
                (map
                    (lambda (element-list) (cdr element-list))
                    seqs
                )
                ;;(accumulate (lambda (value accumulated) (cons (cdr value) aacumulated)) '() seqs)
            )
        )
    )
)

(define s '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))
(accumulat-n + 0 s)

#|
最开始卡了很久, 一直试图在第二个地方使用(cdr seqs)
难点在于如何进行第n个数的位置信息传递

想了很久才想到构造一个子list元素减1的list, 然后继续取第一个数  
不需要传递位置信息  
这个思路第一章应该也出现过, 但是忘掉了

此外这两个子句在逻辑上也有所耦合  
|#
