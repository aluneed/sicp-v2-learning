#lang scheme

;;; exercise 1.23 ;;;


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


(define (prime? n) (
    = (smallestDivisor2 n) n
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

(define (smallestDivisor2 x) (
    iterator2 2 x
))
(define (iterator2 n x) (
    cond
        ((> (* n n) x) x)
        ((= (remainder x n) 0) n)
        (else (iterator2 (+ n 1) x))
))

(searchForPrimes 10000000000001)  ;;10000000000037 *** 60  ;;10000000000037 *** 104
(searchForPrimes 100000000000001)  ;;100000000000031 *** 173  ;;100000000000031 *** 319 158
(searchForPrimes 1000000000000001)  ;;1000000000000037 *** 548  ;;1000000000000037 *** 984 540
(searchForPrimes 10000000000000001)  ;;10000000000000061 *** 1724  ;;10000000000000061 *** 3093

#|
没有快到两倍, 虽然想说是判断问题, 但是我在1.21复制过来的代码中并没有额外的判断
比值大概1.79~1.84波动
((> (* n n) x) x)奇偶无关
(+ n 2)和(+ n 1)的求值不太可能有影响
可能(= (remainder x n) 0)效率和奇偶有关

看了别人的答案
https://codology.net/post/sicp-solution-exercise-1-23/
他在有额外判断的情况下比值刚好也是1.79
而代码和我1.21代码, 即这里的smallestDivisor函数相同时, 倍率刚好接近2.0
看来不是remainder的奇偶效率差异

我测试了3组更大的值之后, 较小值的误差看上去并没有减少
10000000000000061 *** 1738 
10000000000000061 *** 3150
1.81

100000000000000003 *** 5773 
100000000000000003 *** 11017
1.91

1000000000000000003 *** 16897
1000000000000000003 *** 34908
2.07

10000000000000000051 *** 87358
10000000000000000051 *** 359456
4.11

从10000000000000000001开始测试就很花时间了, 没法再继续了

这种巨大误差不太可能是代码造成的
现在我的电脑还剩34%的电, M1还有大小核
越长的计算过程我越可能去看一些别的东西占用计算资源

老实说这种测试在个人电脑上意义不是很大, 不然我前面也不会得出(= (remainder x n) 0)的计算效率和奇偶性有关这么离谱的结论

唉
感觉该写注释了
代码写完就看不懂了
不知道是因为scheme真的很丑, 还是因为我的代码风格不对
没有ide提示全是白板代码可能也是一个问题
|#
