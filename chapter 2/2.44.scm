#lang scheme

;;; exercise 2.44 ;;;

;;老实说, 有点懒得写这一小节的练习, 因为没法测试  

(define (up-split painter n)
    (if (= n 0)
        painter
        (let ((smaller (up-split painter (- n 1))))
            (below (beside smaller smaller) painter)
        )
    )
)
