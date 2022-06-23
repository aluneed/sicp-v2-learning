#lang scheme

(define (make-interval a b) (cons a b))

(define (lower-bound t)
    (min (car t) (cdr t))
)
(define (upper-bound t)
    (max (car t) (cdr t))
)

(define (add-interval x y)
    (make-interval
        (+ (lower-bound x) (lower-bound y))
        (+ (upper-bound x) (upper-bound y))
    )
)

(define (mul-interval x y)
    (let (
        (p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y)))
        )
        (make-interval
            (min p1 p2 p3 p4)
            (max p1 p2 p3 p4)
        )
    )
)
(define (div-interval x y)
    (if (< (* (lower-bound y) (upper-bound y)) 0)
        "error: maybe zero divisor"
        (mul-interval
            x
            (make-interval
                (/ 1.0 (upper-bound y))  ;;这里的大小顺序并不重要
                (/ 1.0 (lower-bound y))
            )
        )
    )
)

(define (make-center-width c w)
    (make-interval (- c w) (+ c w))
)

(define (center i)
    (/ (+ (lower-bound i) (upper-bound i)) 2.0)
)

(define (width i)
    (/ (- (upper-bound i) (lower-bound i)) 2.0)
)

(define (make-center-percent c p)
    (make-center-width c (/ (* c p) 100.0))
)

(define (percent i)
    (* (/ (width i) (center i)) 100.0)
)

;;; exercise 2.14 ;;;

#|
从直觉上来看, 1/R会放大误差, 但是在再一次取倒数后这种误差会收缩
而R1R2/(R1+R2)中, 除非R1R2的值过大, 不然也不太可能出现较大误差
只能先跑代码观察一下
|#

(define (par1 r1 r2)
    (div-interval
        (mul-interval r1 r2)
        (add-interval r1 r2)
    )
)

(define (par2 r1 r2)
    (let ((one (make-interval 1 1)))
        (div-interval
            one
            (add-interval
                (div-interval one r1)
                (div-interval one r2)
            )
        )
    )
)

(define A (make-center-percent 100 0.1))
(define B (make-center-percent 100 0.2))

(par1 A A)
(par2 A A)
(par1 A B)
(par2 A B)

#|
(49.85019980019981 . 50.15020020020019)
(49.95 . 50.05)
(49.775436844732894 . 50.22543815723586)
(49.924987481221834 . 50.07498751872191)
|#

#|
想了一下, 主要原因在于区间乘法和除法所得的区间上下界并不是线性的, 参考2.9中的结论  
上下界的取值依赖于具体的计算结果  
此外scheme中加减法本身也可能造成精度丢失, 不同的计算方法可能放大这种精度丢失, 参考第一章中的相关习题 
|#