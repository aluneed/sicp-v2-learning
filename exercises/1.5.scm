#lang scheme

;;; exercise 1.5 ;;;

(define (p) (p))
(define (test x y)
    (if (= x 0)
        0
        y
    )
)
(test 0 (p))

#|
debug模式从(test 0 (p))开始
应用序(applicative-order)下计算会先遍历(test 0 (p))的参数列表(大概?)
从内部的表达式(p)开始计算
计算顺序并不是自顶向下的, 而是自底向上的(对当前表达式而言)
自底向上计算也导致(define (p) (p))这种表达式无条件自指的情况下(p)的递归调用栈无限深

正则序(normal-order)自顶向下地进行计算, 参考haskell的惰性求值

对人而言, 选取哪种代换顺序比较灵活
在应用序中, 人对(p)的代换只会进行一次
|#