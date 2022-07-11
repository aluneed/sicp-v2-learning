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

(define (accumulate-n op init seqs)
    (if (null? (car seqs))
        '()
        (cons
            (accumulate op init
                (map (lambda (element-list) (car element-list)) seqs)
            )
            (accumulate-n op init
                (map (lambda (element-list) (cdr element-list)) seqs)
            )
        )
    )
)

;;; exercise 2.37 ;;; 矩阵运算

;;向量点乘
(define (dot-product v w)
    (accumulate + 0 (map * v w))
)

;;矩阵乘向量
(define (matrix-*-vector m v)
    (map 
        (lambda (v num) 
            (map 
                (lambda (x) (* num x))
                v
            )
        )  
        m v
    )
)
;;不确定ij有没有搞反

;;矩阵转置
(define (transpose mat)
    (accumulate-n  cons '() mat)
)

;;矩阵乘法, 需要作为参数的矩阵可乘
(define (matrix-*-matrix m n)
    (let ((columns (transpose n)))
        (map 
            (lambda (m-vector)
                (accumulate 
                    (lambda (n-column accumulated)
                        (cons (dot-product m-vector n-column) accumulated)
                    ) 
                    '()
                    columns
                )
            )
            m
        )
    )
)
(define mat1 '((1 2 3) (4 5 6)))
(define mat2 '((7 8) (9 10) (11 12)))
(matrix-*-matrix mat1 mat2)  ;;((58 64) (139 154))

#|
这里采用的做法是, 对矩阵m中的每一行向量m-vector做处理
m-vector和columns中的每一个向量相乘得点积, 这些点积构成一个新的向量

这个过程好像也可以由矩阵m乘向量n-column替代  
|#
