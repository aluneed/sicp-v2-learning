(define (make-monitored f)
  (define count 0)
  (define (dispatch param)
    (if (equal? param 'how-many-calls?)
      count
      (begin (set! count (+ count 1)) (f param))
      )
    )
  (define how-many-calls? count)
  dispatch
  )

(define s (make-monitored sqrt))
(s 100)  ;;10
(s 'how-many-calls?)  ;;1
(s 4)  ;;2
(s 'how-many-calls?)  ;;2

;;; cooler

(define make-monitored
  (lambda (f)
    (begin
      (define count 0)
      (define (dispatch param)
        (if (equal? param 'how-many-calls?)
          count
          (begin (set! count (+ count 1)) (f param))
          )
        )
      (define how-many-calls? count)
      dispatch
      )
    )
  )

(define make-monitored
  (lambda (f)
    (define count 0)
    (lambda (param)
      (if (equal? param 'how-many-calls?)
        count
        (begin (set! count (+ count 1)) (f param))
        )
      )
    )
  )

(define make-monitored
  (lambda (f)
    ((lambda (count)
      (lambda (param)
        (if (equal? param 'how-many-calls?)
          count
          (begin (set! count (+ count 1)) (f param))
          )
        )
      ) 0)
    )
  )
