(define f
  ((lambda (state)
     (lambda (x)
       (set! state (* state x))
       state
       )
    ) 1)
  )
;(f 0)
;(f 1)
(+ (f 1) (f 0))
(+ (f 0) (f 1))
