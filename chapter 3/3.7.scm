(define (make-account balance pwd)
  (define pwdList (cons pwd '()))  ;;'(pwd)是错的, (cons pwd '())是对的, `(,pwd)也是对的, (list pwd)也是对的
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             amount
        )
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (addPwd newPwd)
    (cons newPwd pwdList)
    )
  (define (dispatch inputPwd m)
    (if (member pwd pwdList)
      (cond
        ((eq? m 'withdraw) withdraw)
        ((eq? m 'deposit) deposit)
        ((eq? m 'addPwd) addPwd)
        (else (error "Unknown request - MAKE-ACCOUNT" m))
        )
      (error "Incorrect password")
      )
    )
  dispatch
  )

(define (make-joint account oldPwd newPwd)
  ((account oldPwd 'addPwd) newPwd)
  account
  )

(define peter-acc (make-account 100 'open-sesame))
(define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))

((peter-acc 'open-sesame 'withdraw) 40)
((paul-acc 'rosebud 'deposit) 50)
((peter-acc 'open-sesame 'withdraw) 40)
