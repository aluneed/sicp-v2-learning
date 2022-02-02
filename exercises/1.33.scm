#lang scheme

;;; exercise 1.33 ;;;

(define (accumulate filter combiner f a next b value) (
    if (> a b)
        value
        (accumulate filter combiner f (next a) next b (calc filter combiner f a value))
))
(define (recAccumulate filter combiner f a next b value) (
    if (> a b)
        value
        (calc filter combiner f a (recAccumulate filter combiner f (next a) next b value))
))
(define (calc filter combiner f a value) (
    if (filter a)
        (combiner (f a) value)
        value
))

;;test
(define (filter1 a) #t)
(define (f1 a) a)
(define (next1 a) (+ a 1))
(accumulate filter1 + f1 1 next1 10 0)
(accumulate filter1 * f1 1 next1 5 1)
(recAccumulate filter1 + f1 1 next1 10 0)
(recAccumulate filter1 * f1 1 next1 5 1)
;;居然没bug 感觉自己又行啦

;; a)

;;先写一个m什么r什么检测复习一下
(define (prime? x) (
    if (= x 1)
        #f
        (mrTest x 10)  ;;(mrTest x 3) -> (mrTest x 5) -> (mrTest x 10)
))
(define (mrTest x times) (
    cond
        ((= times 0) #t) 
        ((= (fastExpRemainder (getRandom x) (- x 1) x) 1) (mrTest x (- times 1)))
        (else #f)
))
(define (getRandom n) (
    if (> n 4294967087)
        (- n (random 4294967087))
        (+ 1 (random (- n 1)))
))
(define (fastExpRemainder a n m) (
    cond
        ((= n 0) 1)
        ((odd? n) (remainder (* a (fastExpRemainder a (- n 1) m )) m))
        (else (remainder (expt (fastExpRemainder a (/ n 2) m) 2) m))
))

(accumulate prime? + f1 1 next1 10 0)  ;;boom, (getRandom 1)报错, 加了个1不是素数的判定
;;>17  ;;=2+3+5+7
#|
发现一个问题, 所得值有时候是21
对4的素数检测结果有概率出错
(getRandom 4)连续3次得到1就会判断错误, 这个概率还不小
|#

(accumulate prime? + f1 100 next1 1000 0)
;;这个测试了几次, 得到的值也不稳定, 而且meTest第二个参数为3时非常不稳定, 改为5后有所改善, 最后改成10了

(define (answerA a b) (
    accumulate prime? + f1 a next1 b 0
))

;; b)

(define (getFilterB n)
    (define (filterB i) (
        = (gcd i n) 1
    ))
    filterB
)
;;测试的时候发现 gcd居然是内置的函数
;;之前有道题里面想要写一个类似的getNext来构造(next a)用到的函数next, 没猜出来怎么写, 这次猜对了
;;上面的calc函数可能也能用上

(accumulate (getFilterB 10) * f1 2 next1 10 1)
;;>189 ;;=3*7*9

(define (answerB n) (
    accumulate (getFilterB n) * f1 2 next1 n 1
))