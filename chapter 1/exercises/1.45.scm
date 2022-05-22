#lang scheme

;;; exercise 1.45 ;;;

#|
e1.3.3的笔记中已经发现
f(x) = x0 + f'(x0)dx  
(f(x)+x)/2 = (x0 + f'(x0)dx + x0 + dx)/2 = x0 + ((f'(x0)+1)/2)dx  
(f(x)+x)/2 - x = (f'(x0)-1)/2 * dx  
这样一次迭代会使得x变大或者变小, 取决于f'(x0)相对于1的大小
即单次阻尼平均的结果
(f(x)+x)/2 = x - (1 - f'(x0))/2 * dx | x=x0+dx,dx>0
如果f'(x0) > 1, 那么这次平均阻尼反而会使得x进一步偏离x0
再做一次平均阻尼的结果
(x+(f(x)+x)/2)/2 = (2x - (1 - f'(x0))/2 * dx)/2 = x - (1 - f'(x0))/4 * dx
看起来还是起不到作用
先写代码试试算了
|#

(define (averageDamp f)
    (lambda (x) (
        / (+ x (f x)) 2
    ))
)
(define tolerance 0.0000000001)
(define (fixedPoint f guess) (
    let ((nextGuess (f guess))) (
        if (< (abs (- nextGuess guess)) tolerance)
            nextGuess
            (fixedPoint f nextGuess)
    )
))
(define (mySqrt x)
    (fixedPoint (averageDamp (lambda (y) (/ x y))) 1.1)
)
(mySqrt 2)
(define (cubt x)
    (fixedPoint (averageDamp (lambda (y) (/ x (* y y)))) 1.1)
)
(cubt 8)


(define (repeat f times)
    (define (compose f g) 
        (lambda (x) (
            f (g x)
        ))
    )
    (define (iterator f times resultFunction) (
        if (= times 1)
            resultFunction
            (iterator f (- times 1) (compose f resultFunction))
    ))
    (iterator f times f)
)

(define (p4t x)
    (fixedPoint ((repeat averageDamp 2) (lambda (y) (/ x (* y y y)))) 1.1)
)
(p4t 2)

(define (p5t x)
    (fixedPoint ((repeat averageDamp 2) (lambda (y) (/ x (* y y y y)))) 1.1)
)
(p5t 2)


#|
这几个求x的n次根方式和牛顿法求方程的根问题其实不是一回事
共同点在于都转变成了求不动点问题, 但是等式变换的依据和迭代的方式都不相同
求x的n次方根问题也可以转变成一个适用于牛顿法的问题
y = expt(x, 1/n) = (expt x (/ n))
即y满足
g(y) = y^n - x = 0 | x,n在这里为已知常量
f(y) = y - g(y)/g'(y)
     = y - (y^n - x)/(ny^(n-1))
     = (1-1/n)y + x/(ny^(n-1))
求y = expt(x, 1/n)等价于求f(y)的不动点
|#

(define (newtonRoot x n)
    (define (f y) (
        +
            (* y (- 1 (/ n)))
            (/ x (* n (expt y (- n 1))))
    ))
    (fixedPoint f 1.0)
)
(newtonRoot 15 4)

#|
重新来考虑y=x/y^(n-1)的情况
经过一次平均阻尼
y=(y^n+x)/(2y^n-1)
两次
y=(3y^n+x)/(4y^n-1)
三次
y=(7y^n+x)/(8y^n-1)

整理之后发现和牛顿法得到的等式有一定的联系
k次平均阻尼所得迭代式
y = (1 - 1/2^k) + x/(2^k*y^(n-1))
当2^k=n时, 和f(y)等价
2^k>=n
k>=log(2, n)时, 必然成立
遗憾的是, 这只是充分条件

经过一系列测试得到结果
n   k   
2   1   
3   1   
4   2 
5   2
6   2
7   2
8   3
很容易看出
2^(k+1) > n
k > log(2, n) - 1 = log(2, n/2)
在限定k为正整数后, 实际上和上面的k>=log(2, n)等价
试了一下round和floor, 都是内置函数
|#

(define (root x n)
    (fixedPoint ((repeat averageDamp (floor (log n 2))) (lambda (y) (/ x (expt y (- n 1))))) 1.1)
)
(root 16 4)
(root 2 6)