#lang scheme

;;; exercise 1.22 ;;;

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
        (reportPrime (- (runtime) x x xstartTime))
        #f
))
(define (reportPrime elapsedTime)
    (display " *** ")
    (display elapsedTime)
)


(define (prime? n) (
    = (smallestDivisor n) n
))
(define (smallestDivisor x) (
    iterator 3 x
))
(define (iterator n x) (
    cond
        ((> (* n n) x) x)
        ((= (remainder x n) 0) n)
        (else (iterator (+ n 2) x))
))

#|
要说是不是√10倍, 那确实是, 因为到n=1000001为止, 时间记录出来都是0
现在的算力和以前不可同日而语
|#

(searchForPrimes 1000001)  ;;1000003 *** 0
(searchForPrimes 100000001)  ;;100000007 *** 0
(searchForPrimes 1000000001)  ;;1000000007 *** 0
(searchForPrimes 10000000001)  ;;10000000019 *** 2
(searchForPrimes 100000000001)  ;;100000000003 *** 16
(searchForPrimes 1000000000001)  ;;1000000000039 *** 18
(searchForPrimes 10000000000001)  ;;10000000000037 *** 60
(searchForPrimes 100000000000001)  ;;100000000000031 *** 173
(searchForPrimes 1000000000000001)  ;;1000000000000037 *** 548
(searchForPrimes 10000000000000001)  ;;10000000000000061 *** 1724

#|
前面的数据由于整体时间太短, 误差较大
后面的几组测试比较符合√10的倍数关系

运行时间是否正比于步数的问题
如果是判断单个数是否为素数的步数, 显然与步数的平方根成正比
如果是寻找大于某个值n的最小素数的步数, 同样不成正比, 因为素数分布完全是个谜
至少从目前的几步来看, 个位和十位组成的值并非随值n单调变化, 更不与n的平方根成正比
同时, 在遍历前面几个值时, 如果整除发生的较早, 时间消耗也会少
|#