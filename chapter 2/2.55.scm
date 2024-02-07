#lang scheme

;;; exercise 2.55 ;;;

'abcd  ;;abcd
(quote abcd)  ;;abcd

(quote (quote abcd))  ;;'abcd
(car (quote (quote abcd)))  ;;quote
(cdr (quote (quote abcd)))  ;;(abcd)
(cadr (quote (quote abcd)))  ;;abcd

#|
可以看出, '和quote过程确实是等价的  
尝试car, cdr, cadr后可以发现  
这三个过程实际上是在对`(quote abcd)`进行求值  
也就是说, 'abcd被求值后得到了(quote abcd), 而非符号abcd, 这可能是由于解释器转换导致的  
然后作为一个符号构成的列表被进一步引用
也就是'(quote abcd), 这一步求值结果就是列表(quote abcd)
而quote本身在列表中出现时可能作为`'`输出, 而单独出现时则作为quote输出
|#