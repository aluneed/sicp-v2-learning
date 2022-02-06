#lang scheme

;;; exercise 1.43 ;;;

(define (compose f g) 
    (lambda (x) (
        f (g x)
    ))
)

(define (repeat f times)
    (define (iterator f times resultFunction) (
        if (= times 1)
            resultFunction
            (iterator f (- times 1) (compose f resultFunction))
    ))
    (iterator f times f)
    ;;(iterator f times (lambda (x) x))  ;;当迭代终止条件为(= times 0)
)
(define (square x) (* x x))
((repeat square 2) 5)  ;;625

#|
repeat这种函数在习惯之前, 写起来真是让人毫无信心

顺便
(define (nextF f init)
    (lambda (x) ((repeat f x) init))
)
就很接近阿克曼函数了, 如果将nextF f x的值重新带入f, 等价于阿克曼函数的一个参数+1
只要再在外层控制nextF的迭代次数, 就可以构造出阿克曼函数的另一个参数
|#

(define (ackermann x y) (
    cond
        ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (
            ackermann (- x 1) (ackermann x (- y 1))
        ))
))

(define (nextF f init)
    (lambda (x) ((repeat f x) init))
)
(define (inc x) (+ x 2))

(define (f n) (ackermann 0 n))  ;;f(n)=2n|n>0

(define (g n) (ackermann 1 n))  ;;g(n)=ackermann(0,ackermann(1,(n-1)))=f(ackermann(1, (n-1)))=f(g(n-1))=f()=2ackermann(1, (n-1))=2g(n-1)=2^(n-1)g(1)=2^n | n>0
                                ;;g(n)=f(g(n-1))
(define (h n) (ackermann 2 n))  ;;h(n)=ackermann(1, ackermann(2, (n-1)))=g(ackermann(2, (n-1)))=g(h(n-1))=g(g(h(n-2)))=2^(2^(...^1)) |n>0
                                ;;h(n)=g(h(n-1))
(define (i n) (ackermann 3 n))

(define (repeatF n) ((nextF inc 0) n))  ;repeatF(n) = 2n
(define (repeatG n) ((nextF repeatF 1) n))  ;;repeatG(n) = 2^n
(define (repeatH n) ((nextF repeatG 1) n))  ;;repeatH(n) = 2^...^2
(define (repeatI n) ((nextF repeatH 1) n))  ;;repeatI(n) = ...

(f 3)
(repeatF 3)
(g 3)
(repeatG 3)
(h 3)
(repeatH 3)
(i 3)
(repeatI 3)