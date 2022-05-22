#lang scheme

;;; exercise 1.20 ;;;

(define (gcd a b) (
    if (= b 0)
        a
        (gcd b (remainder a b))
))

#|
正则序

(gcd 206 40)
(gcd 40 (remainder 206 40))
    | 40,6 在if中计算(remainder 206 40)一次
    | t=1
(gcd (remainder 206 40) (remainder 40 (remainder 206 40))) 
    | 6,4 在if中计算(remainder 40 (remainder 206 40))一次
    | t=2
(gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
    | 4,2 在if中计算(remainder (remainder 206 40) (remainder 40 (remainder 206 40)))一次
    | t=4
(gcd
    (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
    (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
)
    | 2,0 在if中计算(remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))一次
    | t=7
(remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
    | =2

迭代步数为n时, if中remainder调用次数为Rn
则
R0=1
R1=2
Rn=R(n-1)+R(n-2)+1
对(gcd 206 40)来说
R=1+2+4+7+4=18
总共18次

应用序
(gcd 206 40)
(gcd 40 6) | 调用一次
(gcd 6 4) | 调用一次
(gcd 4 2) | 调用一次
(gcd 2 0) | 调用一次
总共4次

|#
