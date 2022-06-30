#lang scheme

;;; exercise 2.17 ;;;

;;先进行一下测试
'(1)  ;;(1)
(car '(1))  ;;1
(cdr '(1))  ;;()

(define (last-pair data-list)  ;;好想用驼峰命名啊
    (if (null? (cdr data-list))
        data-list
        (last-pair (cdr data-list))
    )
)

(last-pair (list 23 72 149 34))