#lang scheme

;;; exercise 1.12 ;;;

(define (pascalValue line column) (
    getSum line column
))

(define (getSum line column) (
    cond
        ((> column line) 0)
        ((= column line) 1)
        ((= column 1) 1)
        (else (
            +
            (getSum (- line 1) column)
            (getSum (- line 1) (- column 1))
        ))
))
