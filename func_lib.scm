#lang scheme

(define (map dataList) ())

(define (for-each dataList) ())

(define (for-each-iv dataList) ())

(define (tree-map dataTree) ())

(define (reduce accumulator init dataList) ())

(define accumulate reduce)

(define (flatmap ))

(define (listGet items index)
    (if (= index 0)
        (car items)
        (listGet (cdr items) (- index 1))
    )
)

(define (range ))