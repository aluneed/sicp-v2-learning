* scheme内部定义函数形参和外部环境的变量名重复时会发生变量遮蔽shadowing, 理想情况下编辑器应该给出警告, 不知道为什么scheme编译器和解释器都不这么做  
这真的是好特性吗?(有时候java中的lambda的e确实容易重复, 但我宁可花点心思去想个新名字. 何况java是直接报错, 虽然不至于那么严格, 但有警告总是好的)  
不仅是scheme或go还是typescript, 任何语言发生shadowing的地方都应该给出警告  

* 不要在用DrRacket debug自指的表达式(比如练习1.5)时点暂停或者❌, 

* 如果进行步进调试, 在陷入死循环之前按下cmd+b或cmd+k, 可以避免DrRacket整个卡死

* 不知道哪种scheme代码风格比较好

* 递归过程和迭代计算过程

很多时候我们希望一个迭代计算过程中, 有一些变量来存储中间结果  
如果为了函数的参数列表尽可能精简, 那么可能会分配一个函数作用域外的变量来存储中间结果, 在迭代中不断对其进行更新

递归过程中不使用这种作用域外的变量, 而是直接将变量作为参数在自调用时传给自身, 作为下一次调用的参数  
这样存储中间结果的变量总是能够保持在函数作用域内  
缺点就是, 每个用于存储中间结果的变量, 都会以参数的方式在每次被调用时传递给函数本身

* 第一章回顾

* 基础计算
```
    quotient 整除数
    remainder 余数
    odd? 判奇
    even? 判偶
    (expt a b) a^b
    (exp x) e^x
    (log 2.718281828) ln2.718281828
    (log 100 10) ln100/ln10 ? log10 100
    (random n) 0~(n-1)的随机自然数  expected: (or/c (integer-in 1 4294967087) pseudo-random-generator?)
    ((define ) () () ())  有点像宏? 定义一系列过程
    (display value) 打印value
    (newline) 换行, 如果换行之后没有后续的display, 就无法打印所求出的值
    (gcd a b) 求a,b的最大公因数, 若结果为1则ab互质
    (abs x)
    (round x) 向下取整

    (pair? x) 判断是否为pair
    (string-append s1 s2 ...) 拼接字串
```