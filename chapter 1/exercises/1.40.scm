#lang scheme

;;; exercise 1.40 ;;;

(define dx 0.0000000001)
(define (derive f)
    (lambda (x) (
        / (- (f (+ x dx)) (f x)) dx
    ))
)
(define (newtonTransform f) 
    (lambda (x) (
        - x (/ (f x) ((derive f) x))
    ))
)
(define (newtonsMethod f guess) (
    fixedPoint (newtonTransform f) guess
))
(define (fixedPoint f guess) (
    let ((nextGuess (f guess))) (
    if (< (abs (- guess nextGuess)) tolerance)  ;;这里采用的策略是差值变化检测, 也可以考虑采用比值变化检测
        nextGuess
        (fixedPoint f nextGuess)
    )
))
(define tolerance 0.00000000000001)

(define (cubic a b c)
    (lambda (x) (+ (* x x x) (* a x x) (* b x) c))
)
(newtonsMethod (cubic 1 1 1) 1.0)