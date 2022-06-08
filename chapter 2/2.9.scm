#lang scheme

;;; exercise 2.9 ;;;

#|
[l1, r1] add-interval [l2, r2] -> [l1 + l2, r1 + r2]
(r1 - l1) (r2 - l2) -> (r1 + r2 - l1 -l2)
d' = d1 + d2

[l1, r1] sub-interval [l2, r2] -> [r1 - l2, l1 - r2]
(r1 - l1) (l2 - r2) -> (l1 - r2 + l2 - r1) = (l1 + l2 - r1 - r2)
d' = d2 - d1

区间加减对两个区间的处理都是由固定的上界和下届进行的, 因此会有固定的结果  

区间相乘从mul-interval的函数来看, 就需要进行大小比较  
在不同情况下结果会由不同的上界下界乘积组合产生  
除法和乘法保持一致  
|#
