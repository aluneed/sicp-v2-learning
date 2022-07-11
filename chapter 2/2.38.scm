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

;;; exercise 2.38 ;;;

;;从java的reduce()就可以知道, 需要满足结合律, 无状态, 无副作用, 这里出现的都是纯函数, 因此只需要考虑满足结合律  

(define (fold-left op initial sequence)
    (define (iter result rest)
        (if (null? rest)
            result
            (iter (op result (car rest))
                (cdr rest)
            )
        )
    )
    (iter initial sequence)
)
(define fold-right accumulate)

;;(a / b) / c != a / (b / c)
(fold-right / 1 '(1 2 3))  ;;3/2
(fold-left / 1 '(1 2 3))  ;;1/6
;;(list a b c) != (list (list a b) c)
(fold-right list '() '(1 2 3))  ;;(1 (2 (3 ())))
(fold-left list '() '(1 2 3))  ;;(((() 1) 2) 3)

;;满足结合律的情况
(fold-right string-append "" '("1" "2" "3" "4" "5" "6"))
(fold-left string-append "" '("1" "2" "3" "4" "5" "6"))

;;结合律的前缀表达式
;;((op a b) op c) = (op a (op b c))
;;https://zh.wikipedia.org/zh-cn/%E7%BB%93%E5%90%88%E5%BE%8B
;;需要注意的是, 结合律只针对二元运算, 因此前缀表达式和中缀表达式不会产生较大影响  