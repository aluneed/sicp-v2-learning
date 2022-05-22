#lang scheme

;;; exercise 1.46 ;;;

(define (iterativeImprove discriminator optimizer)
    (lambda (x) (
        if (discriminator x)
            x
            ((iterativeImprove discriminator optimizer) (optimizer x))
    ))
)
#|
这样直接写起来很简单, 但如果discriminator和optimizer有单一数量的参数限制, 会使得这两者的实现变成地狱难度
如果不对参数加以限制, 那么就难以确定discriminator和optimizer的具体形式, 这也就是为什么java的很多库需要implement Xable之后override接口才能使用, 这保证了实现的形式是确定的
对optimizer而言, 如果只能使用guess作为输入参数, 那么无可避免地需要引用外部的x0
对discriminator而言, 如果只能使用guess作为输入参数来判断是否达到迭代要求, 那么也不得不引入外部状态量
|#


(define tolerance 0.000001)

;;1.1.7
(define (goodEnough? guess x) (
    < (abs (- (expt guess 2) x)) tolerance
))
(define (improve guess x) (
    / (+ guess (/ x guess)) 2
))

(define (iterativeImprove117 discriminator optimizer)
    (define (iterator guess initValue)
        (let ((nextGuess (optimizer guess initValue))) (
            if (discriminator nextGuess initValue)
                guess
                (iterator nextGuess initValue)
        ))
    )
    (lambda (x) (iterator x x))
)

(define (mySqrtFirst x) (
    (iterativeImprove117 goodEnough? improve) x
))

;;1.3.3
#|
问题在于
不动点的判别式discriminator的参数是相邻的两个估计guess和nextGuess
并且通过optimizer优化时的参数也只有一个
|#

#|
(define (closeEnough? guess previousGuess) (
    < (abs (- guess previousGuess))
))
(define (f x) (
    / (+ x (/ initValue x) 2
))
(define initValue 2.0)
(define (iterativeImprove discriminator optimizer)
    (lambda (x) (
        if (discriminator x)
            x
            ((iterativeImprove discriminator optimizer) (optimizer x))
    ))
)

(define (findFixedPoint f) (
    (iterativeImprove discriminator optimizer) 1.0
))
|#

#|
想了很久还是没有把这两种情况统一起来
找了下网上的答案
https://codology.net/post/sicp-solution-exercise-1-46/
答案中也针对两个过程给出了不同的iterativeImrove
在1.1.7的算法重写时, 这个答案通过在sqrt内部定义googEnough?和improve
从而引用了外部的x(即sqrt的参数x), 使得函数的参数只有一个

这个答案中写到
The problem here is that the function to check if a guess is good enough requires the next value. The only option that I found was to rewrite iterative-improve so that it takes two arguments
虽然1.3.3重写的答案没有使得参数变为1个, 但是按照前面的思路, 可以在定义closeEnough时调用一次optimizer

于是有
|#


#|
前面的代码
(define (iterativeImprove discriminator optimizer)
    (lambda (x) (
        if (discriminator x)
            x
            ((iterativeImprove discriminator optimizer) (optimizer x))
    ))
)
(define tolerance 0.000001)
|#

;;1.1.7
(define (iterativeSqrt x)
    (define (goodEnough? guess) (
        < (abs (- (expt guess 2) x)) tolerance
    ))
    (define (improve guess) (
        / (+ guess (/ x guess)) 2
    ))
    ((iterativeImprove goodEnough? improve) x)
)
(iterativeSqrt 2.0)  ;;1.4142135623746899

;;1.3.5
(define (iterativeFixedPoint f initGuess)
    (define (improve guess) (f guess))
    (define (closeEnough? guess) (
        < (abs (- guess (f guess))) tolerance
    ))
    ((iterativeImprove closeEnough? improve) initGuess)
)
(iterativeFixedPoint (lambda (x) (/ (+ x (/ 2.0 x)) 2.0)) 2)

#|
教训: 通过内部定义进行外部引用, 进而减少函数的参数个数(以前似乎在哪里看到过这个)
在java中并不提倡这么做
在fp中这种定义出来的函数也不是纯函数?
但由于这些进行了外部引用的函数本身都是外层函数的内部定义, 所以最外层的函数本身不会有什么问题

这个题的难点不在于写iterativeImprove本身
而在于如何构造descriminator和optimizer
|#