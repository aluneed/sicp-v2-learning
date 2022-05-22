#lang scheme

;;; exercise 1.15 ;;;

(define (cube x) (* x x x))

(define (p x) (- (* 3 x) (* 4 (cube x))))

(define (sine angle) (
    if (< (abs angle) 0.1)
        angle
        (p (sine (/ angle 3.0)))
))

#|

a)
sine 12.15 -> (p (sine (/ 12.15 3.0)))
经过一次迭代, 很容易发现, 每次迭代使得函数自变量等比地递减
3^4=81, 3^5=243, 12.15/0.1=121.5
p的调用次数等同于(/ angle 3.0)调用次数, 因此需要调用5次

b)
显然, 步数增长的阶为theta(log(a))
空间增长的阶也是如此

最开始我还怀疑这个递归计算过程中, p的栈深是否计入空间消耗
在尝试计算(sine 1e400)之后爆栈了

---

这个三角恒等式性质很不错
关键在于构造出了一个等式, 使得sin x的计算被转化为sin x/3的计算
同时sin x/3的迭代非常快
最终在x较小时, 可以使用sin x ≈ x的代换

|#