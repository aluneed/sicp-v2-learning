#lang scheme

;;; exercise 2.41 ;;;

(define (flatmap func sequence)
    (accumulate append '() (map func sequence))
)

(define (make-tuple-list size n)
    (if (< n size)
        '()
        (if (= size 0)
            '(())
            (append
                (make-tuple-list size (- n 1))
                (map (lambda (e) (cons n e)) (make-tuple-list (- size 1) (- n 1)))
            )
        )
    )
)
(make-tuple-list 2 5)
(make-tuple-list 3 5)

;;elegant!
;;size元组中的组合问题, 比书上的二元组问题更为复杂
;;可以考虑通过flatmap改写(然而scheme标准都没给flatmap, 感觉不划算)
;;n和size的判断顺序能否对换? 试了一下没有任何问题, 写的时候一直在纠结谁先谁后  

(define (make-tuple-list size n)
    (if (= size 0)
            '(())
        (if (< n size)
            '()
            (append
                (make-tuple-list size (- n 1))
                (map (lambda (e) (cons n e)) (make-tuple-list (- size 1) (- n 1)))
            )
        )
    )
)
(make-tuple-list 2 5)
(make-tuple-list 3 5)