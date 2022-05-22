#lang scheme

;;; exercise 1.34 ;;;

(define (f g) (
    g 2
))

#|
普通的代换
(f f)
(f 2)
(2 2)

经过验证, 三个过程报错均一致为
application: not a procedure;
 expected a procedure that can be applied to arguments
  given: 2
|#