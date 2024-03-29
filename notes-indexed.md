# 0 目录 Contents
# 0 非官方说明 Unofficial Texinfo Format
# 0 献词 Dedication
# 0 序 Foreword
# 0 第2版前言 Preface to the Second Edition
# 0 第1版前言 Preface to the First Edition
# 0 致谢 Acknowledgments
# 1 通过过程(procedure)建立抽象 Building Abstractions with Procedures 构造过程抽象
## 1.1 程序设计的基本元素 The Elements of Programming
### 1.1.1 表达式 Expressions
### 1.1.2 命名和环境 Naming and the Environment
### 1.1.3 组合式的求值(计算组合式) Evaluating Combinations
### 1.1.4 符合过程 Compound Procedures
### 1.1.5 过程应用的代换模型 The Substitution Model for Procedure Application
### 1.1.6 条件表达式和谓词 Conditional Expressions and Predicates

`cond`  
如果无法找到值为真的谓词表达式`<p>`, 那么`cond`的值就没有定义  
否则返回第一个谓词表达式`<p>`为真时对应的序列表达式`<e>`  

`if`
必定对两个分支之一进行求值, 因此一定会有返回值  

这两者的差异在语义上是说得通的  
因为`if`表达式的两个分支组成了可能情况的全集  
而`cond`的所有表达式表示的分支并不一定能组成全集(也可能组成全集的情况下还有重复的情况, 但由于先后顺序而忽略后续的分支)  


`cond`谓词逻辑后的序列表达式可以是多个过程的组合
```scheme
(define (test x)
  (cond
    ((= x 1)
      (display 1)
      (newline)
      -1
    )
  )
)
(+ (test 1) 1)  ;;0
(test 2)  ;;show nothing
```

### 1.1.7 实例: 采用牛顿法求平方根 Example: Square Roots by Newton's Method
### 1.1.8 过程作为黑箱抽象 Procedures as Black-Box Abstractions
## 1.2 过程与它们所产生的计算 Procedures and the Processes They Generate
### 1.2.1 线性的递归和迭代 Linear Recursion and Iteration
### 1.2.2 树形递归 Tree Recursion

#### **斐波那契数列的两种定义方式, 描述和过程**

最开始因为书中讲的东西太过显然, 一下子看过去了

其实仔细想想, 求斐波那契数列的第n项的两种递归表示的代码其实含义有着巨大差异

第一种是对定义的直接翻译  
这段代码每次计算n-1和n-2项值之和时, 都会重新对第n-1项和n-2项分别求值  
这个叙述逻辑非常有普适性  
但是斐波那契数列有特殊性: 计算第n-2项时, n-2项的计算过程是n-1项计算过程的一颗子树

这也就是第二种代码优化的由来: 重复使用已经进行过的求值过程(使用结果, 而不真的重复计算)

当然这是从递归定义开始优化

实际上从斐波那契数列的自然语言描述: 从第三项开始, 每一项的值都是前两项之和
来看, 我们能很自然地认为斐波那契数列的计算复杂度是线性的, 从而也能从自然语言定义中引出第二段代码  

回到引出具有巨大差异的代码的两种定义本身

第一种定义是递归定义, 结合数学归纳法可以描述数列中的第n项, 但给出定义并不能描述数列的第n项值

第二种定义是自然语言定义, 它描述了一种根据前两项计算第三项的过程, 这种对过程的描述给出了第有限n项的值, 但不能将n扩展至正整数域

这是第1章第20条注释的一个非常好的例子——说明性描述(递归定义)和行动性描述(前两项之和)有着内在的联系  
但同时说明性的知识和行动性的知识之间也存在差异

遗憾的是, 了解到这一点并不能直接让我们能设计出更好的算法, 因为说明性的描述翻译出来的代码只是在暴算  
在数学中, 一条递归定义就已经说明了一切, 但对计算机这行不通

#### **换钱**

一开始看书上的说明 没仔细看也没看太看明白

我的第一反应是将问题按单个硬币进行划分, 然后根据硬币数量进行组合, 最终求出组合数  
经过简单尝试之后发现这种思路行不通  
原因在于不同面值的硬币并不总是相邻种类硬币的整数倍, 比如25美分和10美分硬币  
这种硬币的存在会导致存在跨上层面值硬币的划分  
比如2枚25美分的硬币一起换钱的组合, 并不是2个1枚25美分硬币换钱的组合  
可以简单举出反例: 1枚25美分硬币换钱最多只能有2枚10美分硬币参与, 但2枚25美分硬币换钱却能换到5枚10美分硬币

如果不同面值的硬币总是相邻面值硬币面值的整数倍, 那么可以转换为简单的组合问题

书中给出的说明则是这么个意思:  
我们有3个1美元硬币, 这3枚硬币换钱的组合数可以被划分成两种不同组分  
1. 3个1美元硬币全部换掉, 不保留1美元面值硬币的所有组合数
2. 2个1美元硬币的全部换钱组合数

这看起来有点违反直觉, 为什么我们的第2条划分依据是2个1美元硬币换钱的所有组合数, 而不是保留部分(在这个情景下则是保留1枚或2枚)1美元硬币的所有组合, 即如下划分
1. 3个1美元硬币全部换掉, 不保留1美元面值硬币的所有组合数
2. 2个1美元硬币全部换掉, 保留1枚1美元面值硬币的所有组合数
3. 1个1美元硬币换掉, 保留2枚1美元面值硬币的所有组合数

仔细列出条件之后我们会发现, 这里的第2,3条划分出的情况之和"恰好"是前面被划分出的第二种情况
当1美元硬币的数量上升到n时, 这种恰好也恰好成立

按部就班地列出分支条件, 再进行条件合并也是一种不错的方法, 哪怕看上去会绕点远路

如何才能直接得出如同书中说明般的结论呢?


我认为关键在于如何进行**子问题的划分**

在根据硬币的数量, 罗列不同数量硬币换钱的组合时, 我们划分问题的依据是根据表征的硬币数量  
这本身没有问题, 我们可以轻易地算出组合数量, 再乘上单个硬币的换钱组合, 然后按照硬币的种类递归下去就行了  
如果稍加观察, 也可以发现进行不同分类进行讨论的分支, 同样有着合并和简化的空间, 得出与书中相同的递归过程

而如果要直接得出与书中相同的递归过程, 则需要更好地进行子问题的划分  
我们一开始也做了子问题划分, 只是划分的结果没有那么精妙  
其间的差异在于: 精妙的子问题划分, 使得其中一个**子问题又变成了原问题**

回顾我最初的问题划分方式: 将n枚1美元硬币的换钱方式划分为不同数量1美元硬币的换钱组合数之和, 总共有n项
这种划分方式产生了n个子问题, 某些情况下(比如相邻面值为整数倍)我们可以组合1美元换钱来解决所有的子问题, 然而在这个问题下并不成立  
这种划分方式存在几个问题:
1. 粒度太细, 不够概括不够抽象, 没有提取出所有子问题的特征(当然如果适当合并分支就可以解决)
2. 没有构造出一个与原问题相同的问题

是不是如果足够聪明, 就可以直接划分出一个和原问题一致的子问题?  
对换钱这种简单问题来说, 也许是的, 但对于稍稍复杂的问题来说, 就不是那么回事了  
一个比较典型的例子就是, 求斐波那契数列的通项公式

以数列求和问题来说, 无论最终的计算是递归地还是迭代地, 我们都免不了去构造一些等式, 使得它总是同时满足n+1与n以及n与n-1之间的关系
在求斐波那契数列通项的时候, 我们也免不了用上待定系数法或者求线性变换矩阵的特征值, 才能构造出一个与原问题相同的子问题

在为复杂问题构造递归过程时, 知识和经验同样重要

此外, 更细粒度的问题划分, 有时候会更有助于优化

假设我们有4枚1美元的硬币  
按照上面的划分方式, 需要计算
1. 所有4枚1美元硬币全部换钱的组合数
2. 3枚1美元硬币(部分或全部)换钱的组合数

其中问题1会转变成: 求8枚0.5美元硬币换钱的组合数  
而问题2会划分出一个新的子问题: 3枚1美元硬币全部换钱的组合数, 进而转变为6枚0.5美元硬币换钱的组合数  
而8枚0.5美元硬币换钱组合数在经过两次递归计算后, 会产生出一个子问题: 6枚0.5美元硬币换钱的组合数  

由此, 会产生若干次重复的计算

优化方式很容易能想到几种  
一种是书上提起的缓存已经计算过的结果  
另一种是针对0.25美元币值的硬币换钱组合做特殊处理, 其余情况则是单个硬币换钱的组合数乘以硬币数量
另一种, 很显然这是一个组合数学问题

考虑一个更为一般的问题
对满足等式S = ∑Di*Ni的所有Ni求出组合数量  
其中Di和S都是已知常量  

    这是一个线性约束条件下的组合问题
    查了一下, 但是大多数相关的都是组合优化相关的  https://en.wikipedia.org/wiki/Combinatorial_optimization
    关联习题1.14

尝试了一下移项然后利用正整数条件构造不等式, 但是没看出什么东西, 印象中这是个解决方案, 但也仅仅是印象了  
此间偶然发现这个问题很容易写成  
S为n维已知向量D和未知向量N的标量积, 其中向量D,N的分量为正整数(为0时不对结果造成影响, 因此省略)  
求可能的向量N的数量

问题看上去开始变得非常简单(至少几何意义容易直观理解)  
要做的事情变成了, 在任意可数n维空间中, 求N的分量为正整数时, N在D上投影为S的所有可能情况的数量

遗憾的是我所受的数学教育不足以支撑对四维及以上空间的几何想想  
为了便于理解, 先考虑3维的情况
我们有向量D(d1, d2, d3)和投影S, 令k*D·D=S, 可以得到k的值  
于是我们得到了一个过kD点且垂直于D的平面, 同时也是一个平面点集  
当然这个点集的方程满足d1*x+d2*y+d3*z=S
这个平面点集是个无穷集, 但正整数的条件将集合缩小, 限定在第一卦限的有限点集上

对任意可数n维空间来说, 这也同样成立

遗憾的是要在这样一个只有单个方程描述的平面上找出所有满足条件的点集也不是一件容易的事  
但这种能用自然语言简单表述的几何问题, 很可能已经被解决了

---

感觉在数学问题上花了太多时间, 不管是书中的例子还是习题

进度有点太慢了

还是应该把重心放在书本身的内容上

之后开始阅读进度优先, 然后延迟几天再通过习题复习

---

看到个数学解法
用足够多的 1 分，2 分和 5 分硬币凑出 1 元钱，一共有多少种方法？ - 酱紫君的回答 - 知乎
https://www.zhihu.com/question/21075235/answer/2492131289

生成函数的形式将自然数放到指数位置上, 得以通过次数分离这些自然数, 同时又能在求值时将其统一

https://baike.baidu.com/item/%E7%94%9F%E6%88%90%E5%87%BD%E6%95%B0/1198009
参考

### 1.2.3 增长的阶 Orders of Growth (增长)的阶, 不是 (增长的)阶
### 1.2.4 求幂 Exponentiation 指数运算
### 1.2.5 最大公约数 Greatest Common Divisors 最大工共因子(把乘数看作因子之积)
### 1.2.6 实例: 素数检测 Example: Testing for Primality

**费马检查**

尝试和猜想

    a < n
    a mod n = 0

    4^5 mod 5 = 4
    4^4*4 mod 5 = 4
    (4^4 mod 5) * 4 = 4

    3^15 mod 15 = 12
    (3^14 mod 15) * 3 = 9 * 3 =27

    寻找迭代过程中的变换

     a^n mod n
    =a^(n-1)*a mod n
    =(a^(n-1) mod n)

    ?a*b mod n =(a mod n + b mod n) mod n  //错的

对余数太陌生了  
缺个中间结论  
补一下证明

    a*b = kn+c0
    a = in+c1
    b = jn+c2

    ijn + ic2 + jc1 = k
    c1c2 = c0

    a*b mod n = (ijnn + (ic2+jc1)n + c1c2) mod n
    到这里已经可以看出右边括号里前两项模n为0了
    a*b mod n = (ijnn + (ic2+jc1)n + c1c2) mod n
              = c1c2 mod n
              = (a mod n)(b mod n) mod n

    再补证明
    (∑ai) mod n的变换
    ai = kin + bi
    (∑ai) mod n = (∑(ki)n + ∑bi) mod n = (∑bi) mod n
    右边第二个等号比较显然, 但也想不出怎么证明, 印象中有个同余定理
    查了一下还真行  //todo 同余定理证明
    (∑ai - ∑bi) mod n = (∑ki)n mod n = 0

    于是
    (∑ai) mod n = (∑(ki)n + ∑bi) mod n
                = (∑bi) mod n
                = ∑(ai mod n) mod n
    
    对 (∏ai) mod n
    ai = kin + bi
    (∏ai) mod n = (... + ∏bi) mod n 
                = (∏bi) mod n
                = ∏(ai mod n) mod n
    因为除了∏bi的项都是n的整数倍

于是迭代变换为
    
    a mod n = a | a<n

     a^n mod n
    =a^(n-1)*a mod n
    =(a^(n-1) mod n)*(a mod n) mod n
    =(a^(n-1) mod n)*a mod n
    =(a^t mod (t+1))*a mod (t+1) | t=n-1

     a^n mod n
    =(a^(n/2))*(a^(n/2)) mod n
    =(a^(n/2) mod n)*(a^(n/2) mod n) mod n
    =(a^t mod 2t)*(a^t mod 2t) mod 2t | t=n/2

     a^n mod m
    =a^(n-1)*a mod m
    =(a^(n-1) mod m)*a mod m

     a^n mod m
    =(a^(n/2))^2 mod m
    =(a^(n/2) mod m)^2 mod m

这一串推导写下来之后, 突然感觉自己对之前几个迭代计算过程理解还不够深刻  
练习1.16中虽然总结了迭代计算过程中传入参数的变换, 但是感觉不怎么清晰明了  
这里用t去进行代换之后突然悟了, 虽然在这个地方进行代换没什么必要, 因为很难写成迭代计算过程

```scheme
    
(define (checkPrime a n) (
    = (fastRemainder a n) a
))

(define (fastRemainder a n) (
    iterator a n n
))

;;evaluate a^n mod m
;;一开始写a^n mod n的时候还是很困难, 后来加了个m作为除数的记录
#|
     a^n mod m
    =a^(n-1)*a mod m
    =(a^(n-1) mod m)*a mod m

     a^n mod m
    =(a^(n/2))^2 mod m
    =(a^(n/2) mod m)^2 mod m
|#
(define (iterator a n m) (
    cond 
        ((= n 0) 1)
        ((odd? n) (remainder (* a (iterator a (- n 1) m)) m))
        (else (remainder (expt (iterator a (/ n 2) m) 2) m))
))
```
测试(checkPrime 19998 19999)的时候为#t, 还以为是代码写错了  
后来19998换了个值就对了  

费马检查快的关键就在于  
一个只能遍历至sqrt n的过程, 通过费马小定理转换成了一个高次幂的求余问题  
高次幂的求余问题如果直接计算效率也十分低下, 但是有了上面的同余变换式之后, 很容易采用之前的做法, 针对指数进行优化

## 1.3 用高阶函数做抽象 Formulating Abstractions with Higher-Order Procedures 用高阶函数构造抽象
### 1.3.1 过程作为参数 Procedures as Arguments
### 1.3.2 用lambda构造过程 Constructing Procedures Using lambda

**变量遮蔽/屏蔽 variable shadowing**

看到中文版第43页时, 一段示例代码中发生了变量屏蔽/隐藏(尽管书中没有提起这个名次)

总感觉在哪看见过这个这个特性的, 一时想不起来

java中是没有这个特性的, 但是onJava8-09-polymorphism中提到了super和sub类的重名问题

找了一圈之后发现是在typescript中被提起  
https://www.tslang.cn/docs/handbook/variable-declarations.html  
变量声明-重定义及屏蔽

原版文文档  
https://www.typescriptlang.org/docs/handbook/variable-declarations.html#re-declarations-and-shadowing  
Re-declaration and Shadowing


我不太喜欢这个特性, 但是看scheme的代码感觉也说得通  
毕竟let表达式的本质就是一个lambda表达式带入了一些指定的值  

但是在sicp中文版第42页中, 不管是lambda表达式的写法还是let的写法  
都引用到了外部的x和y  
也就是说, let和lambda中, 都可以合法引用外部量名  
而当let覆盖使用了外部量的名称时, 无法引用同名的外部变量  
这些不同的做法明显是有歧义的, 并且取决于let中的命名  
这个做法有好有坏, 但至少应该由编译器给出warning


(define (f x y) (
    (lambda (a b) (
        + x y a b
        )
    )
    (* 2 x) (* 2 y)
))

(define (f x y) (
    (lambda (a b) (
        +
            (* x (* a a))
            (* y b)
            (* a b)
        )
    )
    (+ 1 (* x y))
    (- 1 y)
))

### 1.3.3 过程作为一般性的方法 Procedures as General Methods

#### **折半查找**

//以前就有个问题, 二分查找和三分或者更多分查找的优缺点是什么, 一些二维搜索算法倒是会用到四叉树或者更多分支的树, 从这方面去考虑可能和查找时的变量维度有关, 可以猜想为n维向量设计的算法可以在2^n叉树上构建(如果每个分量都独立的话, 可能拆分为n个二分查找比较好)

一段错误代码
```scheme
;;f(a)*f(b) < 0
(define (iterHIS f a b precision) (
    (let ((average (/ (+ (f a) (f b)) 2)) (halfDiff (/ (- (f a) (f b)) 2))) (
        cond
            ((< (abs average) precision) (/ (+ a b) 2))
            ()
    ))
    
))
```
求根其实是不依赖f(a)和f(b)之差的, 而只依赖f(a)*f(b) < 0这个条件, 同时还能避免凸点/凹点逼近0的情况(此时f(a)*f(b) > 0))

```scheme
;;f(a)*f(b) < 0
(define (pn? x) (/ x (abs x)))
(define (his f a b precision) (
    iterHIS f a b precision (pn? (f a)) (pn? (f b)) 0
))
(define (f x) x)
(define (iterHIS f a b precision pnA pnB lr) (
    let ((average (/ (+ b a) 2.0))) (
        cond
            ((< (abs (- b a)) precision) 
                (if (= lr pnA) a b)
            )
            ((> (* (f average) pnA) 0) (iterHIS f average b precision pnA pnB pnA))
            ((> (* (f average) pnB) 0) (iterHIS f a average precision pnA pnB pnB))
            (else average)
    )
))
```
虽然代码对称了很舒服, 但实际上只解决了一些特殊情况下的问题  
多数情况下二分查找求根还是解不出f(x)=x|f(x)=0的精确解

暂时没想到递归计算过程怎么写  
感觉这就是一个天然的迭代计算过程

#### **不动点**

没什么好说的, g(x)=f(x)-x, 求g(x)=0的根

```scheme
(define (pn? x) (/ x (abs x)))
(define (his f a b precision) (
    iterHIS f a b precision (pn? (f a)) (pn? (f b)) 0
))
(define (iterHIS f a b precision pnA pnB lr) (
    let ((average (/ (+ b a) 2.0))) (
        cond
            ((< (abs (- b a)) precision) 
                (if (= lr pnA) a b)
            )
            ((> (* (f average) pnA) 0) (iterHIS f average b precision pnA pnB pnA))
            ((> (* (f average) pnB) 0) (iterHIS f a average precision pnA pnB pnB))
            (else average)
    )
))

(define (fixedPoint f a b precision) (
    his (lambda (x) (- (f x) x)) a b precision
))
(fixedPoint sqrt 0.5 1.6 0.00000001)  ;;1.0000000067055226
```

如果采用牛顿法, 可以参考书中的例子, 对f(x)=x可以进行恒等变换  
    2f(x) = f(x) + x  
<=> f(x) = (f(x)+x)/2  
理想情况下, 在点(x, f(x))附近, 能够通过取x和f(x)的平均值来逼近f(x)  
假设f(x)在f(x0)=x0处连续且可导  
那么对lim(dx->0) f(x) = f(x0)+f'(x0)dx | x=x0+dx,dx>0 有  
f(x) = x0 + f'(x0)dx  
(f(x)+x)/2 = (x0 + f'(x0)dx + x0 + dx)/2 = x0 + ((f'(x0)+1)/2)dx  
(f(x)+x)/2 - x = (f'(x0)-1)/2 * dx  
这样一次迭代会使得x变大或者变小, 取决于f'(x0)相对于1的大小  
看起来不太妙, 因为这个迭代可能让结果偏离x0  

写一段代码测试一下
```scheme
(define (fixedPoint f x tolerance) (
    if (< (abs (-  (f x) x)) tolerance)
        x
        (fixedPoint f (/ (+ (f x) x) 2) tolerance)
))
(fixedPoint sqrt 1.1 0.00000001)  ;;工作良好
;;随意地选取一个有两个不动点, 但在两个不动点处导数分别大于/小于1的函数, f(x)=x*x
(define (f x) (
    * x x
))
(fixedPoint f 0.1 0.00000001)  ;;7.3346101674538565e-9
(fixedPoint f 1.1 0.00000001)  ;;死循环
```
写代码之前检查了很多次上面的推导是不是有错误,  
但事实证明这些简单分析是对的, 早知道就直接测试了

看上去这种方法远远没有二分查找的实现具有一般性

再来分析一下两种方法的迭代效率

带平均阻尼的逐步逼近法
x'-x = (f'(x0)-1)/2 * dx, dx取决于x逼近不动点x0的程度

二分查找法  
x' = (x1+x2)/2 = (2x0 + dx1 + dx2)/2 | dx1<0<dx2  
x' = x0 + (dx1+dx2)/2  
x = x0 + dx1  
x'-x = (dx2 - dx1)/2  
由于对符号的控制, x'相对于x总是朝x0逼近|(dx2 - dx1)/2| = (|dx1|+|dx2|)/2  
这个值是略大于dx1=x-x0的, 大多少可能和f''(x0)dx1有关

不论如何, 二分查找的收敛速度看上去更快  
更重要的是, 二分查找十分稳定

### 1.3.4 过程作为返回值 Procedures as Returned Values

#### **牛顿法**

    f(x0) = x0 - g(x0)/g'(x0) = x0 - 0 = x0 | g(x0) = 0
    这看上去像一段废话, 但在x偏离x0后, 事情会复杂一点, f(x)成为了一个根据g(x)特殊构造出来的函数
    在x=x0+dx时, g(x)/g'(x)的比值会相当接近dx, 在x处做g(x)的切线很容易看出来
    这样, f(x) = x - g(x)/g'(x)会比x更为接近x0
    有限次计算f(f(f(...f(x))))之后, 得到的值就是满足f(x)=x的不动点的近似, 同时也是g(x)=0的近似解
    
    本质上是将g(x)的求根问题转换成了f(x)的求不动点问题, 而f(x)求不动点过程是一个可以通过迭代计算解决的问题

    虽然在几何上f(x0) = x0 - g(x0)/g'(x0)的意义很明确, 但是在代数上却不是如此
    很难想出只从代数的角度考虑时如何构造出这个f(x)

    x-f(x) = g(x)/g'(x)这样看起来会自然一点
    考虑在x0附近的x=x0+dx
    x0+dx - f(x0+dx) = g(x0+dx)/g'(x0+dx) ≈ g(x0+dx)/g'(x0)
    g'(x0)x0 + g(x0+dx) - g(x0) - f(x0+dx)g'(x0) = g(x0+dx)
    g'(x0)x0 - f(x0+dx)g'(x0) ≈ 0
    x0 ≈ f(x0 + dx) = f(x)
    由于g'(x0) ≈ g'(x0+dx)的近似, 导致丢失了二阶小量, 得到了一些无法相等的式子
    但变换的最终结果x0 ≈ f(x0 + dx) = f(x) 是我们想要的
    也就是说, 对x0附近的x计算f(x), 会逐渐逼近x0
    这是牛顿法迭代过程有效性的一个简单说明(并没有严格证明), 严格证明可能会需要引入二阶小量

    g(x0) = 0
    g(x0+dx) = g'(x0)dx + o(dx) = g(x0+dx)-g(x0)+o(dx)  这个等式已经等不起来了, 可能和x的二阶小量o(dx)有关
    g(x0+dx)


```scheme
;;求导数
(define dx 0.0000000001)
(define (derive f)
    (lambda (x) (
        / (- (f (+ x dx)) (f x)) dx
    ))
)
(define (newtonTransform f) 
    (lambda (x) (
        - x (/ (f x) ((derive f) x))
    ))
)
```

# 2 通过数据建立抽象 Building Abstractions with Data 构造数据抽象

复合数据 - 提升程序设计时所处的概念层次, 提高设计的模块性, 增强语言的表达能力  

分子分母构成复合数据对象的例子提到了"粘在一起", 这是让分子分母之间形成耦合, 构成复合数据对象  
适度的耦合是能带来好处的(实际情况中也经常用到, 比如名称的编码)  

数据抽象 - 将程序中处理数据对象的表示的部分, 与处理数据对象的使用的部分分离  

与复合过程一样, 需要考虑的问题, 也是将抽象作为克服复杂性的一种技术  

数据抽象能够在程序不同部分建立起适当的抽象屏障  

类和对象(当然还有struct)是是构造复合数据对象的一种机制, 能够将一些数据对象组合起来, 形成更复杂的数据对象  

## 2.1 数据抽象导论 Introduction to Data Abstraction 不知道怎么翻译成数据抽象引导的

过程抽象:  
有关过程的实现细节可以被隐藏, 这个特定过程可以由另一个具有相同行为的过程取代 - 这一过程的使用方式, 与该过程究竟如何通过更基本的过程的具体实现分离  

这类似于接口  

类似的,  
数据抽象:  
将一个复合数据对象的使用, 与该数据对象怎样由更基本的数据对象组成/构造的细节分离  

java的基本语法中没有直接对应的概念  
但一个对象中的`getter`和`setter`实际上就实现了这种分离  
此外, `Collection<T>`也是一种抽象数据类型, 对容器的很多操作都和具体元素类型无关  

数据抽象的基本思想, 就是设法构造出一些使用复合数据对象的程序, 使它们就像使在"抽象数据"上操作一样  

程序中使用数据的方式最好是这样的:  
除了完成当前工作所必要的东西外, 不需要对所用数据做任何多余的假设  
同时, 一种"具体"数据表示的定义, 也应当与程序中使用数据的方式无关  

这两个部分之间的界面将是一组技术 - 选择函数和构造函数, 它们在具体表示之上实现抽象数据  

从后面的例子来看, `(cons a b)`通过构造函数将具体数据分别代入`a`, `b`构造成了一个抽象数据的具体实例(虽然这个构造是一种过程, 并没有进行持久化也没有状态, 必须作为过程类型的值来传递, 或者通过`define`来定义到一个符号中, 这种定义类似于状态保存, 但它始终是过程类型的值)  
`car`和`cdr`则通过处理上面的抽象数据来得到值, 这种处理过程是无关`a`或`b`的具体值的  

### 2.1.1 实例: 有理数的算数运算 Example: Arithmetic Operations for Rational Numbers

#### 序对

```scheme
(define x (cons 1 2))
x
(car x)
(cdr x)
```

drRacket的输出为  
```
(1 . 2)
1
2
```

可以看出, `(cons a b)`真的会产生一个值为`(a . b)`的序对类型的具体数据  

当然, 在`2.1.3`小节也指出了`cons`可以完全由过程实现  

### 2.1.2 抽象屏障 Abstraction Barriers

抽象屏障分离了"使用数据抽象的程序"和"实现数据抽象的程序"  

从作用上看, 每一层次中的过程构成了抽象屏障的界面(interface, 感觉翻译成接口更符合工业界的习惯), 联系起系统中被多个抽象屏障划分的不同层次  

这里举的例子很类似于getter和setter  

过程抽象和数据抽象看上去都可以通过接口来完成(实现)  

练习2.3  
```shceme
(define x (cons (cons 1 2) (cons 3 4)))
x
```

输出
```
((1 . 2) 3 . 4)
(1 . 2)
(3 . 4)
```

在多次嵌套`cons`之后, 得到的具体数据的值打印出来是比较古怪的  

debug了一下午, 不知道为什么数据会出现问题, 回家之后才找出来是括号有问题(下午只发现了一处)  
还是屏幕大有优势  
难以发现错误的另一大原因就是没有静态类型  

看了下其他人的答案, 采用了两边定义以及(点+角度+边长)定义, 代码很多, 具体对边长和面积求值的代码没仔细看了  
我采用相邻边和对边两种方法有点投机取巧了  

### 2.1.3 数据意味着什么 What Is Meant by Data?

```scheme
(define (cons x y) 
    (lambda (flag) 
        (cond 
            ((= flag 0) x)
            ((= flag 1) y)
            (else (error "illegal argument"))
        )
    )
)

(define (car t) (t 0))
(define (cdr t) (t 1))

(define a (cons 1 2))
(car a)
(cdr a)
((cons 1 2) 0)
((cons 1 2) 1)
```

可以看出, 过程同样可以实现数据抽象  

这其实很类似于之前出现过的一种写法(练习1.37)  
通过改变函数本身的加数来达到递增效果(下面的inc2中, 可以直接把x的输入值作为输入函数的初始返回值)  
```scheme
(define (inc1 x n)
    (if (> n 0)
        (inc1 (+ x 1) (- n 1))
        x
    )
)
(inc1 0 5)

(define (inc2 x n func)
    (if (> n 0)
        (inc2 x (- n 1) (lambda (t) (+ (func t) 1)))
        (func x)
    )
)
(inc2 0 5 (lambda (x) 0))
```

练习2.4中的代码更加简洁, 而且具有对称性, 语义初看比较晦涩, 但实际比较好解释  

过程可以作为一种对象(客体)去操作, 自动地提供了一种表示符合数据的手段  

数据的过程性将扮演核心角色  
相关程序设计风格: 消息传递  

### 2.1.4 扩展练习: 区间算术 Extended Exercise: Interval Arithmetic

坏起来了, 看着就很麻烦的问题

Alyssa P. Hacker和Ben Bitdiddle 都不是善茬  

2022.06.23, 隔了挺久, 做完了从2.13开始到2.16的习题  

这些开放式的问题真的有点恶心人  
并非探索的过程恶心, 而是得出的结论难以确证  
很容易由直觉得出一些结论, 然后通过实验排除掉一些可能性, 剩下的结论恰好是正确的  
但却难以给出证明, 只有看了网上的参考才能确信  

## 2.2 层次性数据和闭包性质 Hierarchical Data and the Closure Property 分层数据

仅通过序对这个类型就已经足以构造出所有不同种类的数据结构
这有几个要点:
1. 序对, 以及其他的数据, 都具有指针/引用来代表自身  
2. 序对可以存储两个指针/引用, 这使得序对有能力在储存另一个序对的同时, 再储存一个任意指针或引用, 这使得序对可以任意地扩展  

"建立元素本身也是序对的序对", 具体一点说, 就是序对可以储存另一个序对的指针/引用, 这是表结构得以作为一种表示工具的根本基础, 也就是上面提到的第二点  
这种能力称为`闭包性质`  

注释中写道:  
这里的`闭包`源自抽象代数(不知道和离散数学里的是不是一个东西?)  
如果一个运算作用于某个集合中的元素, 产出的结果仍然是该集合中的元素, 那么这个集合在这个运算/操作下封闭(closed)  
这种性质被称为闭包(closure)  
Lisp社区还用"闭包"描述另一个不相关的概念: 一种表示带有自由变量的过程而实现的技术, 而书中并没有采用这种意义  

> 如果某种组合数据对象的操作满足闭包性质,  
> 就说明 通过它组合起数据对象得到的结果本身还是可以通过同样的操作再进行组合  

大部分集合的node容器对象都是具有闭包性质的  

闭包性质是任何组合功能(any means of combination)的关键因素, 因为它有能力建立起**层次性**的结构(hierarchical structures)  
这种结构由一些部分组成, 而这些部分又由类似的部分组成  

除了最简单的程序外, 所有程序都依赖于一个事实:  
组合式的成员本身还可以是组合式  

p66注释73  
一种组合方法应该满足闭包性质是一种显然的想法  
但许多语言提供的数据组合机制都不满足这一性质, 或者其闭包性质很难利用  
fortran, basic中, 组合数据的典型方式是放入数组, 但元素本身却不能是数组(c可以是数组指针)  
pascal和c允许结构的元素又是这种结构, 但需要去显示地操作指针, 并且限制性地要求结构的每个域都只能包含预先定义好形式的元素  
后面的评论看上去更像是在针对这些语言的类型系统, 限制类型之后却没有提供泛型甚至monad机制, 导致了函数的专用化  
在现代的强类型语言中, 这都得到了解决  

### 2.2.1 序列的表示 Representing Sequences

corresponding - 对应的  

(list e1 e2 ... en) <==> (cons e1 (cons e2 (cons ... en nil))
思考: 如何用cons来实现不定长参数列表的myList?  
好像必须要语言级别支持才行  

`(1 2 3 4)`是`(list 1 2 3 4)`的求值结果  
但如果对`(1 2 3 4)`进行求值, 就会编程将过程`1`应用于参数列表`2 3 4`  

后面会看到, 通过单引号`'`作为前缀, 可以在将list作为值写下  
比如空表`'()`, 包含数字1 2 3的列表`'(1 2 3)`

```scheme
(define list1 (list 1 2 3 4))
(define list2 (cons 0 list1))
(define list3 (cons list2 5))
list1
list2
list3
#|
(1 2 3 4)
(0 1 2 3 4)
((0 1 2 3 4) . 5)
|#
```

书上只介绍了通过`cons`在list表的前面加元素的操作  
测试之后看来, 前后顺序对所得的结果确实有影响, 并不对称  
这可能是因为`list`本身就被约定成在前方加入元素, 否则会无法区分list的根节点(list本身是一颗退化的树)  
如同图2-4所示, 最后一个节点的右值采用了nil

nil <- nihil 拉丁语 什么都没有  
scheme中`nil`是一个普通的名字, 被用作一个变量来表示表尾(list tail?)标记  
`true`也是一个表示真值的普通变量  
scheme采用`()`来表示空表  

cons的实际过程是将第一个参数放进一个元组的左值, 再将元组的右值设置为第二个参数的引用  
当第一个参数是元组时, 不会有任何影响(此时list的结构不变)  
`(cons '(0 1) '(2 3))`也同样能得到`((0 1) 2 3)`的结果, 只是第一个元素变成了元组, 整体仍然是list  
当第二个参数不是list时, 无论如何都无法构成新的list  
因为cons的结果无论如何都会因为第二个非list参数作为右值, 而必然不是list  
参考练习2.22

#### 表操作 

`list-ref`仍然是递归定义的
`append`也是递归定义的, 它的本质是不断找到`list1`的最右值, 再在不断返回的过程中吧`list1`的左值逐个添加到`list2`的最左边  

变长参数列表通过
`(define (function param1 param2 . list) ())`中的`.`来定义
如果形式参数列表中最后一个参数的前面有点号`.`, 那么点号前面的形参就是对应的值, 而最后一个形参则以剩余参数构成的list为值  
也可能出现`(define (function . list))`的情况, 所有的参数都会作为变长参数列表中的列表元素  

#### 对表的映射

```scheme
(define nil '())
(define (scale-list items factor)
    (if (null? items)
        nil
        (cons
            (* (car items) factor)
            (scale-list (cdr items) factor)
        )
    )
)
(scale-list (list 1 2 3 4 5) 10)
```

`scale-list`的代码和前面几个练习中的代码如出一辙, 都是递归地去访问list中的每个元素, 然后在逐层返回时通过`cons`进行组装  
这看起来是一种scheme中访问list的较为通常的策略  

```scheme
(define (map proc items)
    (if (null? items)
        '()
        (cons (proc (car items)) (map proc (cdr items)))
    )
)
(map (lambda (i) (* i i)) '(1 2 3 4 5))
```

```java
public static void main(String[] args) {
    List<Integer> integerList = new ArrayList<>();
    integerList.add(1);
    integerList.add(2);
    integerList.add(3);
    integerList.add(4);
    integerList.add(5);
    List<Integer> squareResult = map((i) -> i * i, integerList);
    System.out.println(squareResult);
}
public static <T, U> List<U> map(Function<T, U> function, List<T> list) {
    if (list.isEmpty()) {
        return new ArrayList<U>();
    } else {
        /** 有副作用的方法 */
//        list.remove(lastElement);
//        List<U> resultList = map(function, list);

        /** 队尾插入, 和scheme略有区别 */
//        T lastElement = list.get(list.size() - 1);
//        List<U> resultList = map(function, list.subList(0, list.size() - 1));
//        resultList.add(function.apply(lastElement));

        /** 采用ArrayList在队首插入可能面临性能问题 */
        T lastElement = list.get(0);
        List<U> resultList = map(function, list.subList(1, list.size()));
        resultList.add(0, function.apply(lastElement));

        return resultList;
    }
}
```

这是一段等价的java代码  
区别在于, java中能够在List的末尾进行操作  
而scheme中的list看上去更像是一种只有头指针的链表, 队尾操作需要遍历list  

如果从队尾开始进行递归处理, 从队首开始处理  
并且如果能够丢弃这个递归过程中的后续continuation  
那么就实现了list map的部分求值  

`map`的重要性不仅在于它代表一种公共模式(一种较为通常的策略)  
还在于它建立了一种处理list的高层抽象  

在`scale-list`的最初定义中, 人的注意力很容易集中在对元素的逐个处理上(即`Function<T, U>`的细节上)  
`map`则强调list到list的一种变换, 变换方式的细节则被隐藏在functino中, 无需关注  

两种形式的定义不影响实际执行方式, 而影响对这个过程的看法(即对语义的理解)  

`map`建立了一层抽象屏障, 隔离了list中元素变换过程的实现与如何提取list中元素再组合变换结果的细节分离开  

这使得我们有可能再保持从序列到序列的变换操作框架的同时, 改变序列实现的底层细节  
有点没看明白这句

### 2.2.2 层次性结构 Hierarchical Structures

推广到序列元素本身也是序列的情况

相比之前对list的递归处理, 树的递归其实只是为每个节点的子list加上了遍历  

需要注意的是  
`'('(1 2) '(3 4))`的写法作为参数传递后会变成  
`((quote (1 2)) (quote (3 4)))`  
对这个值应用`car`的结果是  
`'(1 2)`  
正确的写法是  
`'((1 2) (3 4))`  
只需要外部有一个`'`就行了  
```scheme
(list (list 1 2) (list 3 4))
'((1 2) (3 4))
```

这两种写法是等价的 

```scheme
(define (length items)
    (if (null? items)
        0
        (+ 1 (length (cdr items)))
    )
)

#|(define (count-leaves branches)
    (if (null? branches)
        1
        (+ (count-leaves (car branches)) (count-leaves (cdr branches)))
    )
)|#

(define (count-leaves branches)
    (cond
        ((null? branches) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car branches)) (count-leaves (cdr branches))))
    )
)
(count-leaves '( (1 2) (3 4) ((5 6) 7) ((8 9) (10 11))))
```

注释内的代码问题在于, `car`和`cdr`操作都是应用于pair或list的  
当取到叶子节点时会尝试应用于数字, 于是报错  
这种情况下难以处理类型问题, 值类型也没有单独的容器来容纳  

因此采用`pair?`来进行判断

#### 对树的映射

示例代码中  
第一种写法是对树做遍历  
第二种写法是利用了序列遍历的map, 然后通过构造的lambda对每个子树进行处理  

### 2.2.3 序列作为传统常见接口 Sequences as Conventional Interfaces 序列作为一种约定的界面

命令式语言通常将函数/方法, 即过程作为接口  
而这里似乎倾向于将数据结构作为接口?  

"信号处理工程师们可能会发现, 这种过程可以很自然地用流过一些级联地处理步骤地信号地方式描述, 其中的每个处理步骤实现程序方案中的一个部分"  

其实就是stream或者pipeline  
难点其实在于reduce或者带有accumulate累积的, 依赖集合中其他元素的计算  

#### 序列操作

这里介绍了一系列类似stream的实现(但并没有提供stream接口, 而是显式手动地进行括号嵌套组合)  

将程序表示为一些针对序列的操作, 能帮助我们得到模块化的程序设计  
也就是得到由一些比较独立的片段的组合构成的设计  

注释81中提到了Lisp将list表作为表述有序集合的一种标准媒介(容器)  
并使它们可以通过高阶操作来处理  
APL(Array Programming Language?)中所有的数据都是数组, 也是一种类似的选择  

突然很好奇, 这种一步步对list进行处理的操作, 是不是每次操作都遍历list, 速度会不会下降?  
还是说无论写法, 这种遍历都是必要的?  

#### 练习2.36

无法存储或传递元素在集合中索引信息时的策略  

需要传递元素在集合中的位置信息时, 如果受到限制而无法传递信息  
可以考虑在使用这个元素之后从集合中去除  
然后在处理集合的代码中总是取首或尾元素进行处理, 处理完之后再去除  
如此往复  
这样无需使用位置信息即可实现集合遍历  

练习2.36的难点是需要对所有的子list都这样做, 然后将弹出元素后的子list构造为一个新的list作为递归的参数  

#### 练习2.38 结合律, 操作顺序

https://zh.wikipedia.org/zh-cn/结合律  
在数学中，结合律(associative property)是二元运算可以有的一个性质，意指在一个包含有二个以上的可结合运算子的表示式，只要运算数的位置没有改变，其运算的顺序就不会对运算出来的值有影响。亦即，重新排列表示式中的括号并不会改变其值  

左序和有序计算的本质就是改变了计算顺序, 也就是改变了括号的位置  

结合律的前缀表达式  
((op a b) op c) = (op a (op b c))  

需要注意的是, 结合律只针对二元运算, 因此前缀表达式和中缀表达式不会产生影响  

考虑前缀表达式操作op
(op a b c) = ((op a b) op c) = (op a (op b c))  
这种特殊情况

#### 嵌套映射  这一小节中很多都是组合问题  

这里定义了`flatmap`  
```scheme
(define (flatmap func sequence)
    (accumulate append '() (map func sequence))
)
;;测试示例
(define (accumulate accumulator initial sequence)
    (if (null? sequence)
        initial
        (accumulator
            (car sequence)
            (accumulate accumulator initial (cdr sequence))
        )
    )
)
(define seq1 '((1 2 3) (4 5 6)(7 8 9)))
(flatmap (lambda (x) x) seq1)  ;;(1 2 3 4 5 6 7 8 9)
(define seq2 '((1 2 3) (4 5 6)(7 (8 9))))
(flatmap (lambda (x) x) seq2)  ;;(1 2 3 4 5 6 7 (8 9))
```

`flatmap`无法做到递归地让树形结构扁平化  
java中也是如此  
```jshelllanguage
Stream<Stream<Stream<String>>> stream = Stream.of(Stream.of(Arrays.asList("test", "hello", "world").stream()));
        stream.flatMap(e -> e)
                .peek(e -> System.out.println(e))
                .flatMap(e -> e)
                .forEach(e -> System.out.println(e));
```

这里枚举集合的问题在练习2.32幂集相关问题中也是类似的

### 2.2.4 实例: 一个图形语言 Example: A Picture Language

这一小节大概是在讲如何设计一种dsl?  

这里引入了一个新的概念: "模式(pattern)"  

通过过程来表示元素代表着这样一种意义:  
所有的状态都可以看做是初始状态经过一系列过程后的结果  
因此状态实际上可以由初始(状态)值和过程来描述  

在代数中, 我们经常给出过程方程, 但不对结果值进行求解, 而是按照形式主义的代数运算规则对过程进行简化和规约  

描述语言的重点: 语言的基本原语, 组合手段, 抽象手段  
(以java来说, 抽象手段是类, 组合手段则是类的extends/implements, 或者单纯作为成员变量, 基本原语不知道说的是不是first class object或者别的什么东西)  

示例中给出的painter以及相关运算的闭包性质其实类似于各种集合容器, 以及stream和monad  

在scheme中, 组合的方式就是采用普通的scheme过程(以list为例, 可以由cons进行组合)  

`right-split`和`corner-split`的递归模式是这样的:  
在`let`中递归调用, 构造出`smaller`, 然后再将`smaller`进行拼接  
在进行第一次拼接之前, 会一直递归调用进行右分裂, 直到通过n=0时开始回溯递归过程  

`square-of-four`是一个高阶函数, 接受4个函数分别作为原有的`painter`向四个角进行变换的映射  

关于2.45  
找了个通过lambda实现递归调用的方法  
https://stackoverflow.com/questions/7719004/in-scheme-how-do-you-use-lambda-to-create-a-recursive-function  

```scheme
(((lambda (x) (x x))
    (lambda (fact-gen)
        (lambda (n)
            (if (zero? n)
                1
                (* n ((fact-gen fact-gen) (sub1 n))
                )
            )
        )
    )
)
5
)
```
`(lambda (x) (x x))`作用于第二个lambda函数后, 使其进入自调用的递归过程  
第二个lambda函数则提供并维持了一个能够一直传递函数`fact-gen`的环境  
而`(fact-gen fact-gen)`自调用则可以产生需要进行递归调用的函数  

//todo

## 2.3 符号数据 Symbolic Data

这里的符号大概就是任意字串

### 2.3.1 引号 Quotation

这里着重强调了引号带来的问题  

"大声说你的名字" | "你的名字" -> "aluneed"  
"大声说'你的名字'" | "'你的名字'" -> "你的名字"  

重点都在注释中  
引号破坏了对等的东西可以相互替换的观念, 因此极大损害了根据简单词语在语言中做推理的能力  

这是在说, 本来在形式主义/符号主义的过程中可以进行代换的东西, 由于引号而无法进行代换  
这可以看做是代数中的变量由于引号的作用而变成了一个字符串类型的值, 因此不再具有能够进行代换的代数性质  

书中说scheme中可以不写结束引号, 但实际上在drRacket中, 写上结束引号反而会引起错误 `read-syntax: expected an element for quoting "'", found end-of-file`  

另外的注释提起了两条语法规则  
单引号可以用于表示括起的表和符号, 双引号只能用于字符串  
`'<expression>`是`(quote <expression>)`的语法糖  

由于scheme本身不具有类型, 因此`'<expression>`的类型其实是比较含混的  
它看上去有点像字串  
但实际上在语义上表达的是对`'`后方的对象的引用  
举个例子
```scheme
(print "+")  ;;"+"
(print '+)  ;;+
(print "abc")  ;;"abc"
(print abc)  ;;abc: unbound identifier in: abc
```
可以看出, `print`打印字串时其实都是带上引号了的  
从`(print abc)`的错误提示也可以猜测, `'+`的结果实际上是一个identifier, 它代表了求和这个过程  

继续尝试
```scheme
(define abc "abc")
(print abc)  ;;"abc"
(define (myfunc x) (+ x 1))
(print myfunc)  ;;#<procedure:myfunc>
```
可以看出, `print`会打印出实际引用的东西  
对`(print '+)`来说, 打印出的`+`可能就是加号所引用的内置shceme过程  

```scheme
(eq? 1 (car '(1 2 3)))  ;;#t
(eq? '1 (car '(1 2 3)))  ;;#t

(define abc "abcd")
(eq? abc abc)  ;;#t
(eq? abc "abcd")  ;;#t

(define ls '(1 abc "abcd"))
(eq? ls ls)  ;;#t
(eq? ls '(1 abc "abcd"))  ;;#f
(eq? '(1 abc "abcd") '(1 abc "abcd"))  ;;#f
(eq? '() '())  ;;#t
(define ls2 ls)
(eq? ls2 ls)  ;;#t
```

`eq?`的一系列结果十分令人疑惑, 因为它和注释中的描述表现出不一致的行为  
大体上来看, 在进行比较时, 会比较符号的引用, 而非符号本身  
也就是说, `'`类似于取指针/取引用过程, 而进行`eq?`比较时, 可能会比较引用, 也可以能直接将符号代换为引用的内容再进行比较  
`'(1 abc "abcd")`在构建list之后获取引用, 而两个list虽然内容相同, 但实际引用时不同的, 这也就导致了比较结果为#f  
从测试来看, `eq?`的行为和java的`==`表现十分相似  
甚至连字串和列表的行为也和java类似  
在对字串进行define之后, `eq?`比较字串和其定义的名称, 结果为#t
而对一个非空list进行定义后, 比如上面的`'(1 abc "abcd")`, 哪怕看上去一致, 但实际每次写出来都是重新创建了一个list, 可以看做java写了List.of(..)  

### 2.3.2 实例: 符号求导 Example: Symbolic Differentiation 符号微分

有点懒得做这一小节的练习, 但是又感觉对写parser会有点帮助  

`symbol?`用来判断符号  
只有简单的标识符才是符号
```scheme
(define x 1)
(symbol? x)  ;#f
(symbol? 'x)  ;#t
(define l '(1 2 3))  ;#f
(symbol? l)  ;#f
(symbol? 'l)  ;t
(symbol? '(1 2 3))  ;f
(symbol? 1)  ;f
(symbol? '1)  ;f
(symbol? '())  ;f
```  

### 2.3.3 实例: 集合的表示 Example: Representing Sets

这里面虽然讲了集合的实现, 但是不知道是不是最佳实践  


### 2.3.4 实例: Huffman编码树 Example: Huffman Encoding Trees
## 2.4 抽象数据的多重表示 Multiple Representations for Abstract Data
### 2.4.1 复数的表示 Representations for Complex Numbers
### 2.4.2 带标志的数据 Tagged Data
### 2.4.3 数据导向程序设计和可加性 Data-Directed Programming and Additivity 数据导向的程序设计和可加性 
## 2.5 带有通用型操作的系统 Systems with Generic Operations
### 2.5.1 通用型算数运算 Generic Arithmetic Operations
### 2.5.2 不同类型数据的组合 Combining Data of Different Types
### 2.5.3 实例: 符号代数 Example: Symbolic Algebra
# 3 模块化, 对象和状态 Modularity, Objects, and State
## 3.1 赋值和局部状态 Assignment and Local State
### 3.1.1 局部状态变量 Local State Variables

### 3.1.2 引进赋值带来的利益 The Benefits of Introducing Assignment

例子中的`random-update`并不存在  
找到了一个实现, 但是racket的pretty big并不能使用, 这个仓库用的是chicken scheme  
https://github.com/klutometis/sicp/blob/master/rand-update.scm  
最后还是老实直接用`(random)`了  
https://stackoverflow.com/questions/14674165/scheme-generate-random

示例程序
```scheme
(define (rand) (random 1000))

(define (estimate-pi tirals)
  (sqrt (/ 6 (monte-carlo tirals cesaro-test)))
  )

(define (cesaro-test)
  (= (gcd (rand) (rand)) 1)
  )

(define (monte-carlo trials experiment)
  (define (iter tirals-remaining trials-passed)
    (cond
      ((= tirals-remaining 0) (/ trials-passed trials))
      ((experiment) (iter (- tirals-remaining 1) (+ trials-passed 1)))
      (else (iter (- tirals-remaining 1) trials-passed))
      )
    )
  (iter trials 0.0)
  )

(estimate-pi 100000)
```
一开始`(define (rand) (random 100))`, 随机数范围太小, 可能导致gcd的效果不太好, 计算次数加到1m都还是有较大偏离  
随机数范围加到1000, 计算次数降到100k, 有了更好的结果  
随机数范围10k, 次数1m时, 基本上能稳到3.14..  试了很多次, 偏差小于千分之二  

练习3.5  
我写的predicate感觉有点不对味, 至少不像个积分  
如果是积分的话, 这个predicate应该是和x1,x2相关的, 但这个predicate是手动编写的, 和一个点坐标相关, 并且实际计算的predicate是单位元, 但取点的随机范围却是没有校验的  
在`estimate-integral`中又不应该对传入的predicate做处理  
另外这个方法对pi的估计也没有示例中的准确  

练习3.6
示例中的随机数init和update都不可用, 导致这里没法进行实际测试  
之前在第二章也是被类似的情况恶心到了, 很多东西(包括示例)根本跑不起来  
网上的方案是随便写了个东西做模拟  
```scheme
(define random-init 0)
(define (rand-update x) (+ x 1)) ; A not-very-evolved PNRG 
```
至于这个练习本身的问题, 不同于3.1.1中总是通过一个make函数构造一个带环境的闭包, 这里rand并不会生成一个对象返回给外部, 而是需要保存于它自身  
一开始直接`define (rand method)`了, 没想明白  
关键点在于, 利用lambda x创建一个环境, 然后对这个lambda apply一个初始值  
然后再写出lambda method捕获环境中的x(带初始值)  
另一个需要注意的点是, 对lambda x apply初始值, 是仅在`define rand`时调用一次  
也就是在这时, 创建了一个捕获了带有捕获了x的环境的函数, 然后绑定至rand  
这也是为什么rand被多次调用之后, x还是会发生改变, 因为调用rand并不会创建新的环境  

### 3.1.3 引进赋值的代价 The Costs of Introducing Assignment

练习3.7  
这个练习让我想起一个以前就遇到过的问题: 一大段问题描述中没有定义好接口, 也没有给出测试, 
导致需要花很多精力去构思最终实现出来的东西应该长什么样, 有什么样的shape  
当然这个练习本身描述的没多复杂, 也给出了一个make-joint的使用示例  
但也存在一些没有澄清的要求: 新的密码是否能用于继续创建关联账户? 密码和账户是否必须匹配(这是无法实现的, 因为参数中并没有传入新的用户名)?  
题目给的需求本身用scheme写起来也很傻逼, 也难怪工业界语言都是oop语言  
练习本身的问题在于, 是否创建一个新的对象, 如果创建了, 如何共享状态; 另一个方案则是加入一个合法的密码列表  

踩坑: 创建list时直接用`'(pwd)`形参, 有问题, `'()`中的所有identifier都会作为原始形式  
(cons pwd '())是对的, `(,pwd)也是对的, (list pwd)也是对的  

练习3.8
这个问题本身很简单, 随手构造一个就完事了  
但是"构造f"这个过程, 特别像约束求解(f即约束), 跟ml也有共同之处  
坑: 测试用的(f 0)和(f 1)会影响后续的结果  
并且`(+ (f 0) (f 1))`会影响`(+ (f 1) (f 0))`的结果, 因此测试中也交换了顺序  
只要观测就会导致结果改变, 听着就很耳熟  

## 3.2 求值的环境模型 The Environment Model of Evaluation

要点:  
通过lambda捕获环境变量创建闭包以保存状态  

### 3.2.1 求值规则 The Rules for Evaluation
### 3.2.2 简单过程的应用 Applying Simple Procedures

练习3.9
递归版本:  
全局环境中创建了factorial和一个lambda的绑定  
这里factorial并没有进行尾递归优化  
因此每次递归调用都会创建一个新的栈帧, 直到最后n=1时开始返回  
但每个栈帧Fn的环境En, 都是直接引用global环境的, En之间并没有引用关系  
迭代版本:  
看着就很复杂. factorial和fact-iter被定义在global环境中  
调用(factorial n)会创建一个新的栈帧以构成新的环境E1, 然后在新的栈帧中查找fact-iter, 找不到, 于是继续去global环境中找  
找到之后调用(fact-iter 1 1 n), 这会创建一个新的栈帧以构成新的环境E2  
E2中会继续调用(fact-iter newParams), 这构成了尾递归, 会进行优化  
所以它后续的调用中构成的栈帧应该并不会堆叠在第一次进行fact-iter调用以构成E2环境的栈帧后面, 而是替换掉这个栈帧,  
在环境上也会不断构造新的平行于E2的, 直接引用global环境的新的环境  
此外, 从E2~En的环境也都直接引用global, 并不会引用E1

要点在于: 环境和栈帧的结构并不是一一对应的  
这会导致一些猜想
应用一个过程时的环境可以有两种取法: 一是取过程定义时捕获的环境(即lambda捕获的闭包), 二是取过程调用时的栈帧?  
这是不是分别代表着所谓的静态作用域和动态作用域的根本差异?

### 3.2.3 框架作为局部状态的仓库 Frames as the Repository of Local State 将框架看作局部状态的展台

p170的注释提到了, 不同的对象是否共享过程代码取决于实现  

练习3.10  
行为当然是相同的, 环境有所差异  
```scheme
(define (make-withdraw balance)
  (lambda (amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount)) balance)
        "Insufficient funds!"
        )
    )
  )
(define (make-withdraw balance)
  ((lambda (balance)
    (lambda (amount)
      (if (>= balance amount)
        (begin (set! balance (- balance amount)) balance)
        "Insufficient funds!"
        )
      )
    ) balance)  
  )
```
第一种只有一个显示lambda, 直接捕获了make-withdraw传入的形参balance(在调用make-withdraw时会创建这个环境并捕获形参)  
第二种是let脱糖后的实际过程, 通过lambda balance手动创建了一个新的环境, 然后内层的lambda amount捕获了这个创建的环境中的balance,
调用make-withdraw时, 会将lambda balance应用于传入的参数balance, 然后构造新的环境, 多了一组通过lambda创建环境以提供形参然后apply lambda以提供形参的操作  
实际上给define脱糖就可以发现, 第二种再进行一次let是没必要的  
当然这也是在"balance"这个参数进行值传递的情况(which在scheme和java中总是如此)  

### 3.2.4 内部定义 Internal Definitions

练习3.11
`(define acc (make-account 50))`  
在全局环境中通过`(make-account 50)`创建了一个环境E1, 在其中定义了一系列过程, 并将其中一个过程dispatch返回, 和acc绑定  
`((acc 'deposit) 40)`  
在全局环境中通过acc取得了绑定的E1环境中的dispatch过程, 然后调用dispatch过程, 返回了E1中的deposit过程, 这个调用是在E1环境中进行的  
最后在E1环境中应用(deposit 40)  
`((acc 'withdraw) 60)`  
类似deposit, 没啥好说的  

acc的局部状态保存在哪? E1环境中  
如果acc这个引用没了(也就是make-account创建的对象), E1环境可能被GC回收, 不知道drRacket具体是怎么实现的  
局部状态如何保持不同?  
acc2指向的是通过另一次make-account调用创建的环境中的dispatch, 位于另一个环境E2中  
哪些部分共享?  
相同的过程是否在物理上共享取决于实现(参考p170的注释)  
大体上`eq?`这样的全局过程都是共享的, if/cond/define这类也是共享的, 可能直接由解释器实现或者用宏实现  

## 3.3 通过变动数据建模 Modeling with Mutable Data 用变动数据做模拟
### 3.3.1 变动的表结构 Mutable List Structure
### 3.3.2 队列的表示 Representing Queues
### 3.3.3 表格的表示 Representing Tables
### 3.3.4 数字电路的模拟器 A Simulator for Digital Circuits
### 3.3.5 约束的传播 Propagation of Constraints
checked exception和null检查算么?
## 3.4 并发: 时间至关重要 Concurrency: Time Is of the Essence 并发: 时间是一个本质问题
### 3.4.1 并发系统中时间的性质 The Nature of Time in Concurrent Systems
### 3.4.2 控制并发的机制 Mechanisms for Controlling Concurrency
## 3.5 流 Streams
### 3.5.1 流是延时的List Streams Are Delayed Lists 流作为延时的表
### 3.5.2 无穷流 Infinite Streams
### 3.5.3 流范式的使用 Exploiting the Stream Paradigm 流计算模式的使用
### 3.5.4 流和延时求值 Streams and Delayed Evaluation
### 3.5.5 函数式程序的模块化和对象的模块化 Modularity of Functional Programs and Modularity of Objects
# 4 元语言抽象 Metalinguistic Abstraction
## 4.1 元循环求值器 The Metacircular Evaluator (元循环)求值器
### 4.1.1 求值器的内核 The Core of the Evaluator
### 4.1.2 表达式的表示 Representing Expressions
### 4.1.3 求值器数据结构 Evaluator Data Structures
### 4.1.4 求值器作为程序运行 Running the Evaluator as a Program 作为程序运行这个求值器
### 4.1.5 数据作为程序 Data as Programs
### 4.1.6 内部定义 Internal Definitions
### 4.1.7 将语法分析与执行分离 Separating Syntactic Analysis from Execution
## 4.2 Scheme的变体 - 惰性求值 Variations on a Scheme — Lazy Evaluation Scheme的变形
### 4.2.1 常规(正则)序和应用序 Normal Order and Applicative Order 正则序和应用序
### 4.2.2 一个采用惰性求值的解释器 An Interpreter with Lazy Evaluation
### 4.2.3 流作为惰性的List Streams as Lazy Lists
## 4.3 Scheme的变体 - 非确定性计算 Variations on a Scheme — Nondeterministic Computing Scheme的变形
### 4.3.1 amb和搜索 Amb and Search
### 4.3.2 非确定性程序的实例 Examples of Nondeterministic Programs
### 4.3.3 实现amb求值器 Implementing the amb Evaluator
## 4.4 逻辑程序设计 Logic Programming
### 4.4.1 演绎信息检索 Deductive Information Retrieval
### 4.4.2 查询系统如何工作 How the Query System Works
### 4.4.3 逻辑程序设计是数理逻辑吗 Is Logic Programming Mathematical Logic?
### 4.4.4 查询系统的实现 Implementing the Query System
#### 4.4.4.1 驱动循环及实例化 The Driver Loop and Instantiation
#### 4.4.4.2 求值器 The Evaluator
#### 4.4.4.3 通过模式匹配寻找断言 Finding Assertions by Pattern Matching
#### 4.4.4.4 规则和一致性(单一化?) Rules and Unification
#### 4.4.4.5 数据库的维护 Maintaining the Data Base
#### 4.4.4.6 流操作 Stream Operations
#### 4.4.4.7 查询语法过程 Query Syntax Procedures
#### 4.4.4.8 框架和绑定 Frames and Bindings
# 5 通过寄存器机器计算 Computing with Register Machines 寄存器机器里的计算
## 5.1 寄存器机器里的计算 Designing Register Machines
### 5.1.1 一种描述寄存器机器的语言 A Language for Describing Register Machines
### 5.1.2 机器设计的抽象 Abstraction in Machine Design
### 5.1.3 子程序 Subroutines
### 5.1.4 通过栈实现递归 Using a Stack to Implement Recursion 采用堆栈实现递归
### 5.1.5 指令总结 Instruction Summary
## 5.2 一个寄存器机器模拟器 A Register-Machine Simulator
### 5.2.1 机器模型 The Machine Model
### 5.2.2 汇编器 The Assembler 汇编程序
### 5.2.3 构造指令的执行过程 Generating Execution Procedures for Instructions 为指令生成执行过程
### 5.2.4 监视机器执行 Monitoring Machine Performance
## 5.3 存储分配和垃圾回收 Storage Allocation and Garbage Collection 存储分配和废料收集
### 5.3.1 内存作为向量 Memory as Vectors 将存储看作向量
### 5.3.2 维持无线内存的假象 Maintaining the Illusion of Infinite Memory 维持一种无穷存储的假象
## 5.4 显示控制的求值器 The Explicit-Control Evaluator
### 5.4.1 显示控制的求值器的内核 The Core of the Explicit-Control Evaluator
### 5.4.2 顺序求值和尾递归 Sequence Evaluation and Tail Recursion 序列的求值和尾递归
### 5.4.3 条件, 赋值和定义 Conditionals, Assignments, and Definitions
### 5.4.4 求值器的运行 Running the Evaluator
## 5.5 编译 Compilation
### 5.5.1 编译器的结构 Structure of the Compiler
### 5.5.2 表达式的编译 Compiling Expressions
### 5.5.3 组合式的编译 Compiling Combinations
### 5.5.4 指令序列的组合 Combining Instruction Sequences
### 5.5.5 编译代码的实例 An Example of Compiled Code
### 5.5.6 词法寻址 Lexical Addressing 词法地址
### 5.5.7 连接编译后的代码至求值器 Interfacing Compiled Code to the Evaluator 编译代码与求值器的互连
# 6 参考文献 References
# 7 练习列表 List of Exercises
# 8 配图列表 List of Figures
# 9 索引 Index
# 10 尾页 说明 Colophon
