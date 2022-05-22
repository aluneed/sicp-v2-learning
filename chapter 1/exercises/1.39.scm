#lang scheme

;;; exercise 1.39 ;;;

(define (tanCF x k)
    (define (iter n d k result) (
        if (= k 0)
            result
            (iter n d (- k 1) (/ (n k) (- (d k) result)))
    ))
    (define result (iter (lambda (k) (* x x)) (lambda (k) (- (* 2 k) 1)) k 0.0))  ;;希望这里屏蔽了k, 老实说我压根不想在外层(tanCF x k)用x和k这个变量名
    (/ result x)
)
(tanCF (/ pi 4) 50)