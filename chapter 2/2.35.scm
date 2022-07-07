#lang scheme

;;; exercise 2.35 ;;;

(define (accumulate accumulator initial sequence)
    (if (null? sequence)
        initial
        (accumulator
            (car sequence)
            (accumulate accumulator initial (cdr sequence))
        )
    )
)

;;通常的反应是, 通过map将tree映射到一个叶子节点构成的list上, 然后通过accumulate简单地去count
;;然而这个map并不好写
;;最终直接将map映射到元素的count上(如果元素是子树则递归调用count-leaves, 否则为1)
;;这种思路和小节`对树的映射`以及练习2.30, 练习2.31中的第二种方式是一致的
;;将tree的一个层级当作一个list处理, 如果有元素是子树, 那么再单独处理, 最终得到层级上同类的结果  
;;不知道把树映射为叶子节点list的map能不能在不定义其他函数的情况下写出来  
(define (count-leaves t)
    (accumulate
        (lambda (value accumulated)
            (+ value accumulated)
        )
        0
        (map
            (lambda (element)
                (if (pair? element)
                    (count-leaves element)
                    1
                )
            )
            t
        )
    )
)
(count-leaves '( (1 2) (3 4) ((5 6) 7) ((8 9) (10 11))))