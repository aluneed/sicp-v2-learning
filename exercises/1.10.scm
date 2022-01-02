#lang scheme

;;; exercise 1.10 ;;;

(define (ackermann x y) (
    cond
        ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (
            ackermann (- x 1) (ackermann x (- y 1))
        ))
))

(ackermann 1 10)
(ackermann 2 4)
(ackermann 3 3)
(ackermann 10 2)
;;(ackermann 3 4)
;;(ackermann 4 3)

(define (f n) (ackermann 0 n))
(define (g n) (ackermann 1 n))
(define (h n) (ackermann 2 n))
(define (i n) (ackermann 3 n))

#|

ackermann(x,y)
=0 | y=0
=2y | x=0
=2 | y=1
=ackermann(x-1,ackermann(x,(y-1)))

看上去x与y不具有对称性
尝试带入一些值之后发现确实没有对称性

列出方程f(x,y)=f(x-1, f(x, y-1)), 对x求导得出微分方程之后也看不出什么东西

题目中给出的一组测试所得值比较大, 也具有明显的指数函数所得值特征
考虑到值的快速增加, 只可能在x=0时多次返回2y的值才可能出现这种情况, 进而想到ackermann(0, y), 发现和题目中的(f n)|n=y一致
题目中的f g h函数可能是某种提示, 就算不是, 有一个固定值之后转换为一元分析相对来说也比较容易

(define (f n) (ackermann 0 n))  ;;f(n)=2n|n>0
(define (g n) (ackermann 1 n))  ;;g(n)=ackermann(0,ackermann(1,(n-1)))=f(ackermann(1, (n-1)))=f(g(n-1))=f()=2ackermann(1, (n-1))=2g(n-1)=2^(n-1)g(1)=2^n | n>0
                                ;;g(n)=f(g(n-1))
(define (h n) (ackermann 2 n))  ;;h(n)=ackermann(1, ackermann(2, (n-1)))=g(ackermann(2, (n-1)))=g(h(n-1))=g(g(h(n-2)))=2^(2^(...^1)) |n>0
                                ;;h(n)=g(h(n-1))
继续尝试一下
(define (i n) (ackermann 3 n))  ;;i(n)=ackermann(2, ackermann(3, (n-1)))=h(i(n-1))=h(h(...h(i(1)))) |n>0
                                ;;i(n)=h(i(n-1))


整理一下, 在n>0时有
f(n) = 2n
g(n) = f(g(n-1)) = ... = f(...f(g(1))
考虑使用函数符号的指数来表示多次嵌套
查了一下, 确实有这种表示法, 参考迭代函数 https://baike.baidu.com/item/%E8%BF%AD%E4%BB%A3%E5%87%BD%E6%95%B0/15669566?fr=aladdin
这时我才想起复合函数f(g(x))的表示f·g(x)其实是一个根基, 本科时期的数学教育太侧重于计算, 忽略了符号和抽象(至少工科是如此)
接下来就放心用这种表示法了

于是可以进一步整理
f(n) = 2n = (2+)^(n-1)(2) => f(n)=2n 或记作 f(n) = (2+)^(n-1)(2)
g(n) = f^(n-1)(g(1)) = {(2*)^(n-1)*g(1) | g(1)=2} = 2^n = (2*)^(n-1)(2) => g(n)=2^n 或记作 g(n)=(2*)^(n-1)(2)
h(n) = g^(n-1)(h(1)) = {g^(n-1)(h(1)) | h(1)=2} = g^(n-1)(2) => 记作 h(n)=(2^)^(n-1)(2), 实际上它的展开形式是h(n)=(2^(2^(2^(2^(...^2))))), 不知道有没有专门的记法
    隐约记得微积分历程中讲伯努利兄弟那一章好像提过相关的东西, 但是高中书被同学借走之后一直没还回来, 也没买到新的, 无法确证
    大体上查了一下也没查到相关的东西
i(n) = h^(n-1)(i(1)) = {h^(n-1)(i(1)) | i(1)=2} = h^(n-1)(2) => 记作i(n)=h^(n-1)(2), 考虑到h(n)的展开式, 这里i(n)已经很难展开了

到这里, 规律已经很明显了
f(n)是加分的累积, 即乘法
g(n)是乘法的累积, 即指数
h(n)是指数的累积, 忘了叫啥了
i(n)是忘了叫啥的运算的累积, 还没有被定义(至少初等数学中没有定义)
定义一种新的函数
A(x, y, z)
=0 | y=0
=z*y | x=0
=z | y=1
则ackermann(x,y)是z=2时的一个特例
A(x, y, z)定义了一种以z为底数, 由x确定累积方式, y确定累积次数的一种运算
其中x的累积方式总是x-1累积方式的累积

考虑到数学上的书写习惯
(define (function_i n) (ackermann i n)) | i=C

数学表示
由ackermann(i, n)=2|n=1,i>=1恒成立可知
function_0(n)=2n | i=0
function_i(n)=function_(i-1)^(n-1)(2) | i>=1, n>=1

继续代换
function_i(1)=2
function_i(2)=function_(i-1)^1(2)=function_0(2)=4
function_i(n)=function_(i-1)^(n-1)(2) | i>=1
             =fcuntion_(i-1)^(n-2)(function_(i-1)(2))
             =function_(i-1)^(n-2)(4)
             =function_(i-1)^(n-3)(function_(i-1)(4))
             =function_(i-1)^(n-3)(function_(i-2)^3(2))
看上去异常复杂, 尝试下其他的
function_i(n)=function_(i-1)^(n-1)(2) | i>=1
             =function_(i-1)(function_(i-1)(function_(i-1)(...function_(i-1)(2)...)))
             =function_(i-2)^(function_(i-1)(function_(i-1)(...function_(i-1)(2)...))-1)(2)
             =function_(i-2)^(function_(i-1)^(n-2)-1)(2)
             =function_(i-2)^(function_(i-2)(function_(i-1)(...function_(i-1)(2)...)-1)-1)(2)
             =function_(i-2)^((function_(i-2)^function_(i-1)^(n-3)-1)-1)(2)
看上去还是异常复杂, 并且无法化简
最开始预想的情况是
             =(function_(i-2)^(n-2))^(n-1)(2) | i>=1
             ...
             =(((((function_0^1)^2)^3)^...)^(n-1))(2) | i>=1
但实际上好像不是这样的
很显然, i和n都会影响到函数function_i本身
没有新的数学工具的情况下, 表示这些计算会非常复杂
(ackermann 4 3)和(ackermann 3 4)已经无法计算出结果, 因此也无法通过数值计算来验证一些其他的猜想

当然就算缺少相关知识, 也可以看出上面的这些符号计算和(d/dx),(∂/∂x)以及∇相似, 也就是算子
很容易联想到常被提及的lambda算子, 目前还看不出来这个问题是否能由此解决

总地来说, 这个练习题算是前10题里最具有启发性的
虽然形式主义的数学中充斥着大量的符号计算, 但没想到竟然可以达到这种程度
这个函数的根本复杂性来源于, 任何自变量都影响到了函数本身



查了一下ackermann函数, 来自于威廉 阿克曼(William Ackermann), 希尔伯特的学生
资料还提到了一些递归函数和[原始递归函数]相关的东西, 和可计算理论有关
资料上提到阿克曼函数的独特性在于, 它不是原始递归函数, 但却可计算(也许原始递归函数必定可计算, 而非原始递归函数大概率不可计算?不然这有什么独特的)
原始递归函数 primitive recursive functions
https://zh.wikipedia.org/wiki/%E5%8E%9F%E5%A7%8B%E9%80%92%E5%BD%92%E5%87%BD%E6%95%B0
看上去很重要的性质和定义: 原始递归函数可以用总是停机的图灵机计算，而递归函数需要图灵完全系统

另外就是阿克曼函数以及反阿克曼函数的意义
反阿克曼函数被用来作为衡量时间复杂度的一种标准
阿克曼函数ackermann(i, n)也可以看作是i阶复杂度过程的一种衡量标准
其中i阶用来衡量过程的形式
i=0的情况, 复杂度是线性的
i=1的情况, 复杂度是指数性的
i=2的情况, 复杂度是指数的指数
i=3的情况, 复杂度是???
大部分情况下i<=1

i=2时还存在一些问题, 比较重要的就是, 由于函数是递归定义的
简写afn2(n)=ackermann(2, n)的n无法直接扩展到实数域上, 向实数域扩展可能是个不错的方向(也许已经有了)
此时A(2,x,C)可能会有一个底数C, 使得对应的afn2'(x)=afn2(x), 即d(A(2, x, C))/dx=A(2, x, C)
对A(0,x,C)而言, C=0  (对任意次数的多项式来说, C总是为0, 也就是多项式退化为常数)
对A(1,x,C)而言, C=e
对A(2,x,C)而言, C不一定存在

|#