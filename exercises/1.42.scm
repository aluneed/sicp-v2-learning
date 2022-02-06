#lang scheme

;;; exercise 1.42 ;;;

(define (compose f g) 
    (lambda (x) (
        f (g x)
    ))
)
((compose (lambda (x) (* x x)) (lambda (x) (+ x 1))) 6)  ;;49
;;实际上1.41中的double就可以通过compose来进行定义

