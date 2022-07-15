#lang scheme

;;; exercise 2.40 ;;;

(define (unique-pairs n)
    (if (= 0 n)
        '()
        (append  ;;感觉flatmap不如append来的直观
            (unique-pairs (- n 1))
            (map (lambda (e) (list n e)) (as-list 1 (- n 1)))
        )
    )
)

(define (as-list start n)
    (if (< n start)
        '()
        (append (as-list start (- n 1)) (list n))
    )
)

(unique-pairs 5)
;;((2 1) (3 1) (3 2) (4 1) (4 2) (4 3) (5 1) (5 2) (5 3) (5 4))