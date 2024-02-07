(define makeAccumulator
  (lambda (init)
    (lambda (value) (set! init (+ init value)) init)
    )
  )

(define A (makeAccumulator 5))
(A 10)
(A 10)