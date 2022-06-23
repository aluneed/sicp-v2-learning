#lang scheme

(define (make-interval a b) (cons a b))

(define (lower-bound t)
    (min (car t) (cdr t))
)
(define (upper-bound t)
    (max (car t) (cdr t))
)

;;; exercise 2.11 ;;;

#|
+ +
- +
- -
两两组合, 共9种
这种情况下, 两个- +如[-1, 2] [-2, 3]会出现问题, 因为判断下界需要进行两次乘法然后比较  

卡了很久去网上看了一圈, 所有答案在这种情况下进行了超过2次乘法  
题目大概率有问题, 懒得写了
|#

(define (interval-pn? x)
    (cond
        ((> (lower-bound x) 0) 1)
        ((< (upper-bound x) 0) -1)
        (else 0)
    )
)

(define (mul-interval x y)
    (let (
        pnx (interval-pn? x)
        pny (interval-pn? y)
    )
    (cond  ;;trivial work
    ))
)
