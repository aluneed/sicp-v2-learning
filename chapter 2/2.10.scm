#lang scheme

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

;;; exercise 2.10 ;;;

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

#|test
(define a (make-interval -3 8))
(define b (make-interval 2 13))
(div-interval a b)

> (-1.5 . 4.0)
|#