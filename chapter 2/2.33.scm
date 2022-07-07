#lang scheme

;;; exercise 2.33 ;;;

(define (accumulate accumulator initial sequence)
    (if (null? sequence)
        initial
        (accumulator
            (car sequence)
            (accumulate accumulator initial (cdr sequence))
        )
    )
)
(accumulate * 1 '(1 2 3 4 5))
 
#|
accumulate是这样一个过程  
它接收一个accumulator作为积累函数  
将接收的初始值initial和最后一个参数sequence从后往前进行积累运算  
这个accumulator的形式为(accumulator value accumulated)

accumulate和java stream的reduce()如出一辙  
从下面的实现来看, reduce()也可以做到很多诸如map之类的操作
|#

(define (map function sequence)
    (accumulate
        (lambda (x y)
            (cons (function x) y)
        )
        '()
        sequence
    )
)
(map sqr '(1 2 3 4 5))  ;;(1 4 9 16 25)

(define (append seq1 seq2)
    (accumulate 
        cons 
        seq2
        seq1
    )
)
(append '(1 2 3) '(4 5 6))

(define (length sequence)
    (accumulate 
        (lambda (value accumulated)(+ 1 accumulated))
        0
        sequence
    )
)
(length '(1 2 3 4 5))