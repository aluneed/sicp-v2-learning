#lang scheme

;;; exercise 2.2 ;;;

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

(define (printPoint p)
    (newline)
    (display "(")
    (display (getX p))
    (display ",")
    (display (getY p))
    (display ")")
)

(define p (makeSegment (makePoint -2 -3) (makePoint 7 4)))
(printPoint (midpointSegment p))