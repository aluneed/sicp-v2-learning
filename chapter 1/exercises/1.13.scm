#lang scheme

;;; exercise 1.13 ;;;

#|
对数列F(n)=pF(n-1)+qF(n-2), n大于等于2且为正整数, F(0)=0, 有
F(n)-tF(n-1)=(p-t)F(n-1)+qF(n-2)

令(p-t)/1=q/(-t)
得t^2-pt-q=0
t=(p +- (p^2 + 4q)^(1/2))/2

p=q=1
t=(1-5^(1/2))/2

这里的t是个负数, 并且F(1)=1(而非F(1)=0)

由于(1-5^(1/2))/2小于0且大于-1, 因此t^(n-1)绝对值小于1, 又因为n为正整数时, 通项必为整数
所得值必然为最接近题设的整数

|#

