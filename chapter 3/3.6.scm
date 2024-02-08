(define random-init 0)
(define (rand-update x) (+ x 1)) ; A not-very-evolved PNRG

;; wrong
;(define (rand method)
;  (cond
;    ((eq? method 'reset) random-init)
;    ((eq? method 'generate) (rand-update x))
;    (else (error "unknown method"))
;    )
;  )
;(define (rand method)
;  ((lambda (x)
;     (cond
;       ((eq? method 'reset) (lambda (new-value) (set! x new-value) x))
;       ((eq? method 'generate) (set! x (rand-update x)) x)
;       (else (error "unknown method"))
;       )
;     ) random-init)
;  )

(define rand
  ((lambda (x)
     (lambda (method)
       (cond
         ((eq? method 'reset) (lambda (new-value) (set! x  new-value) x))
         ((eq? method 'generate) (set! x (rand-update x)) x)
         (else (error "unknown method"))
         )
       )
     ) random-init)
  )

(rand 'generate)
(rand 'generate)
(rand 'generate)
(rand 'generate)
((rand 'reset) 0)
(rand 'generate)
(rand 'generate)
(rand 'generate)
