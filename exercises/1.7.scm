#lang scheme

;;; exercise 1.7 ;;;

(define (improve guess x) 
    (average guess (/ x guess)) 
)

(define (average a b) (/ (+ a b) 2))

(define (goodEnough guess x) (
    < (abs (- (/ guess (improve guess x)) 1)) 0.001
    ;;< (abs (- (* guess guess) x)) 0.001
))

(define (abs x)
    (if (> x 0)
        x
        (- x)
    )
)

(define (sqrtIterator guess x) (
    if (goodEnough guess x)
        guess
        (sqrtIterator (improve guess x) x))
)

(define (sqrt x) (
    sqrtIterator 1.0 x
))

;;(sqrt 123e+40)

#|
运行1.6.scm中的代码

对x小于1的情况, 很容易想到(sqrt x)大于x, 因此在通过goodEnough进行精度判断时, 判定方法会很快失效
> (sqrt 0.01)
0.10032578510960605

对x很大的情况, 几次测试之后发现一些问题
(sqrt 123e+40)
(sqrt 16e+44)
(sqrt 25e+44)
(sqrt 64e+44)
(sqrt 123e+44)
其中第2,4,5项都可以瞬间得出结果, 而另外两个事项计算起来则是无尽的循环

第一反应是有一些隐藏的计算优化, 但后发现第5项的结果之后, 可以明白
在某些情况下, 牛顿法收敛地非常快, 但在另一些情况下, 计算结果始终不会收敛

尝试在drRacket中进行debug
itr     guess       x/guess
1       1           1.23e+42
2       6.15e+41    2.0
3       3.075e+41   4.0
4       1.53e+41    8.0
5       7.6865e+40  16.0
6       3.84375e+40
...

很显然在improve的过程中, 求guess和x/guess时发生了精度丢失
第一次迭代后guess的小数部分为0.5, 但会被丢失, 因此x/guess也是精确的2.0

考虑guess接近sqrt(x)|x=1.23e+42的情况
设
g=sqrt(x)+t
g'=(g+x/g)/2
  =(g+(g-t)^2/g)/2
  =(g+(g^2-2gt+t^2)/g)/2
  =(g+g-2t+t^2/g)/2
  =g-t+t^2/g/2
其中t是真实的精度差异, 若浮点数精度丢失, 则t必然丢失

当g远大于t时, 如果科学计数法中t被丢失, 导致迭代结果为g'=g
同时若
g^2=(sqrt(x)+t)^2
   =x+2sqrt(x)*t+t^2
即
g^2-x=2sqrt(x)*t+t^2~=2sqrt(x)*t
|2sqrt(x)*t| >= 0.001时, 
迭代会始终进行下去

违反直觉的是, 输入值更大的情况下,
可能会因为精度丢失导致2sqrt(x)*t被整个丢失, 从而能够正常收敛

总得来说, 无法收敛是因为某些情况下精度丢失, 恰好无法迭代又不满足精度校验条件, 而并非网上一些答案中所说的单纯的因为精度丢失

找到了一个比较完善的参考
https://codology.net/post/sicp-solution-exercise-1-7/
重点在于gap, 以及if we are lucky
另一个比较详细的解答
http://community.schemewiki.org/?sicp-ex-1.7

从直觉上来看, 精度丢失的情况下
能够收敛的值的指数可能是周期性变化的, 而与值的大小无关

|#