#lang scheme

;;; exercise 2.1 ;;;
(define number car)
(define denom cdr)
(define (printRat x)
    (newline)
    (display (number x))
    (display "/")
    (display (denom x))
)

(define (makeRat n d) 
    (let ((gcdResult (gcd n d))) (
        if (< d 0)
            (cons (- (/ n gcdResult)) (- (/ d gcdResult)))
            (cons (/ n gcdResult) (/ d gcdResult))
    ))
)

(printRat (makeRat 3 6))
(printRat (makeRat 3 -6))
