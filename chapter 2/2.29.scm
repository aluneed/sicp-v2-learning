#lang scheme

;;; exercise 2.29 ;;;

(define (make-mobile left right)
    (list left right)
)
(define (make-branch length structure)
    (list length structure)
)
(define x 
    (make-mobile
        (make-branch 6 8)
        (make-branch 2 
            (make-mobile
                (make-branch 6 4)
                (make-branch 3 8)
            )
        )
    )
)

;;a)
(define (left-branch structure)
    (car structure)
)
(define (right-branch structure)
    (car (cdr structure))
)
(define (branch-length branch)
    (car branch)
)
(define (branch-structure branch)
    (car (cdr branch))
)

x
(left-branch x)
(right-branch x)
(branch-length (right-branch x))
(branch-structure (right-branch x))
(branch-length (left-branch x))

;;b)
(define (structure? structure)
    (pair? structure)
)
(define (total-weight structure)
    (if (structure? structure)
        (+
            (total-weight (branch-structure (left-branch structure)))
            (total-weight (branch-structure (right-branch structure)))
        )
        structure
    )
)

(total-weight x)

;;c)
(define (moment branch)
    (* (branch-length branch) (total-weight (branch-structure branch)))
)
(define (balance? structure)
    (if (pair? structure)
        (let ((lb (left-branch structure)) (rb (right-branch structure)))
            (if (= (moment lb) (moment rb))
                (and 
                    (balance? (branch-structure lb))
                    (balance? (branch-structure rb))
                )
                #f
            )
        )
        #t
    )
)

(define y
    (make-mobile
        (make-branch 6 8)
        (make-branch 4 
            (make-mobile
                (make-branch 6 4)
                (make-branch 3 8)
            )
        )
    )
)
(balance? x)
(balance? y)

;;d)

#|
就改改a)里的这俩
(define (right-branch structure)
    (car (cdr structure))
)
(define (branch-structure branch)
    (car (cdr branch))
)
去掉car
|#