#lang scheme

;;; exercise 2.3 ;;;

#|
额外的问题太多了

如果需要在构造过程中对矩形进行校验
最简单的方式就是通过任意两根拥有公共点的线的矢量积为0
当然实际上还是很麻烦

构造过程有2根垂直的线或者等价的3点时也能直接构造出矩形
但在数据结构限定使用cons时
无非就是组成矩形的序对中容纳的两条边是相对边还是相邻边

最简单的情况就是直接通过长和宽来构造矩形, 但丢失位置信息
这很适合作为一个抽象层次, 因为周长和面积都只和长宽有关, 和位置信息不直接有关

|#

(define (makePoint x y) (
    cons x y
))
(define (getX point) (car point))
(define (getY point) (cdr point))

(define (makeSegment startPoint endPoint) (
    cons startPoint endPoint
) )
(define (startSegment segment) (car segment))
(define (endSegment segment) (cdr segment))

(define (getMidpoint point1 point2)
    (let ((x (/ (+ (getX point1) (getX point2)) 2))
        (y (/ (+ (getY point1) (getY point2)) 2))) (
        cons x y
    ))
)
(define (midpointSegment segment) (
    getMidpoint (startSegment segment) (endSegment segment)
))

;;p1-p2-p3-p4-p1, 相对边
(define (makeRectangle1 p1 p2 p3 p4) (
    let ((s1 (makeSegment p1 p2)) (s2 (makeSegment p4 p3)))
        cons s1 s2
))

;;p1-p2-p3-p4-p1, 相邻边
(define (makeRectangle2 p1 p2 p3 p4) (
    let ((s1 (makeSegment p1 p2)) (s2 (makeSegment p1 p4)))
        (cons s1 s2)
))

(define (getValue rectangle) (
    let (
            (p1 (car (car rectangle)))
            (p2 (cdr (car rectangle)))
            (p3 (car (car rectangle)))
            )
        ()
))