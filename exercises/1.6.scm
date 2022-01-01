#lang scheme

;;; exercise 1.6 ;;;

(define (improve guess x) 
    (average guess (/ x guess)) 
)

(define (average a b) (/ (+ a b) 2))

(define (goodEnough guess x) (
    < (abs (- (* guess guess) x)) 0.001
))

(define (abs x)
    (if (> x 0)
        x
        (- x)
    )
)

(define (sqrtIterator guess x) (
    if (goodEnough guess x)
        guess
        (sqrtIterator (improve guess x) x))
)

(define (sqrt x) (
    sqrtIterator 1.0 x
))

;;;

(define (newIf predicate thenClause elseClause) (
    cond
        (predicate thenClause)
        (else elseClause)
))

(define (newSqrtIterator guess x) (
    newIf (goodEnough guess x)
        guess
        (newSqrtIterator (improve guess x) x)  ;;作为参数会直接进行求值
))

(define (newSqrt x) (
    newSqrtIterator 1.0 x
))

#|
> (newSqrt 2)
. Interactions disabled; out of memory

展开newSqrtIterator中的newIf得
(define (newSqrtIterator guess x) (
    cond 
        ((goodEnough guess x) guess)
        (else (newSqrtIterator (improve guess x) x))
))
使用cond的时候并没有出现错误

(define (newSqrtIterator guess x) (
    newIf (goodEnough guess x)
        guess
        (newSqrtIterator (improve guess x) x)  ;;作为参数在application-order中被首先求值
))

cond和if只对谓词逻辑为真的表达式求值

|#