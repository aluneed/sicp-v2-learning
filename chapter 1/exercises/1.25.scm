#lang scheme

;;; exercise 1.25 ;;;

#|
不对
不能

e1.2.6的笔记中已经写到
费马检查快的关键就在于  
一个只能遍历至sqrt n的过程, 通过费马小定理转换成了一个高次幂的求余问题  
高次幂的求余问题如果直接计算效率也十分低下, 但是有了上面的同余变换式之后, 很容易采用之前的做法, 针对指数进行优化

本质上不是直接计算高次幂的余数, 而是通过同余变换进行降次, 再对最终所得的一个较为简单的数求余

此外, 虽然fast-expt的计算速度也很快
就算用这种方法, 步数增长阶为logn^2
但高次幂的末位会被近似省略, 前面有道习题中也专门讨论过这个问题
|#