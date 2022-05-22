#lang scheme

;;; exercise 1.24 ;;;

(define (prime? n) (
    randomIter n 3
))
(define (randomIter n counter) (
    cond
    ((= counter 0) #t)
    ((checkPrime (getRandom n) n) (randomIter n (- counter 1)))
    (else #f)
))
(define (getRandom n) (
    if (> n 4294967087)
        (- n (random 4294967087))
        (+ 1 (random (- n 1)))
))
#|
(define (getRandom n) (+ 1 (random (- n 1))))
(randomIter 10000000000000061 3)
> random: contract violation
  expected: (or/c (integer-in 1 4294967087) pseudo-random-generator?)
  given: 10000000000000060
随便试了一个, 输入参数越界了, 只接受integer类型
只能重新写了个局部随机的, 多了不少开销
|#

(define (checkPrime a n) (
    = (fastRemainder a n) a
))
(define (fastRemainder a n) (
    iterator a n n
))
(define (iterator a n m) (
    cond 
        ((= n 0) 1)
        ((odd? n) (remainder (* a (iterator a (- n 1) m)) m))
        (else (remainder (expt (iterator a (/ n 2) m) 2) m))
))

;;;;;;;; 复用的代码 ;;;;;;;;
(define (searchForPrimes n) (
    outIter n
))
(define (outIter n) (
    if (timedPrimeTest n)
        #t
        (outIter (+ n 2))
))
(define (runtime) (current-milliseconds))
(define (timedPrimeTest n)
    (newline)
    (display n)
    (startPrimeTest n (runtime))
)
(define (startPrimeTest n startTime) (
    if (prime? n)
        (reportPrime (- (runtime) startTime))
        #f
))
(define (reportPrime elapsedTime)
    (display " *** ")
    (display elapsedTime)
)
;;;;;;;;;;;;;;;;;;;;;;;;;

(searchForPrimes 10001)  ;;10007 *** 0#t
(searchForPrimes 10009)  ;;10009 *** 0#t  ;;这算是孪生素数?
(searchForPrimes 10011)  ;;10037 *** 0#t
(searchForPrimes 100001)  ;;100003 *** 0#t
(searchForPrimes 100005)  ;;100019 *** 0#t
(searchForPrimes 100021)  ;;100043 *** 0#t
(searchForPrimes 1000001)  ;;1000003 *** 0#t
(searchForPrimes 1000005)  ;;1000033 *** 0#t
(searchForPrimes 1000035)  ;;1000037 *** 0#t
(searchForPrimes 10000001)  ;;10000019 *** 0#t
(searchForPrimes 10000021)  ;;10000079 *** 0#t
(searchForPrimes 10000081)  ;;10000103 *** 0#t

(searchForPrimes 1000000000000000000000000000000000000000000000001)  ;;1000000000000000000000000000000000000000000000193 *** 0#t
#|
不符合预期
因为机器太快了根本测不出时间
当然费马检测也很快, 从时间一直处于0几乎没有增长来看, 步数增长阶最大就是log n这个量级的
|#