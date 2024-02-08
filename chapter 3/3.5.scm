(define (monte-carlo trials experiment)
  (define (iter tirals-remaining trials-passed)
    (cond
      ((= tirals-remaining 0) (/ trials-passed trials))
      ((experiment) (iter (- tirals-remaining 1) (+ trials-passed 1)))
      (else (iter (- tirals-remaining 1) trials-passed))
      )
    )
  (iter trials 0.0)
  )

(define (random-in-range low high)
  (+ low (* (random) (- high low)))
  )

(define (estimate-integral trials predicate x1 x2 y1 y2)
  (* (monte-carlo trials (lambda () (predicate (random-in-range x1 x2) (random-in-range y1 y2)))) (- x2 x1) (- y2 y1))
  )

(define (point-predicate x y)
  (<= (+ (sqr x) (sqr y)) 1)
  )
(estimate-integral 100000 point-predicate -1 1 -1 1)