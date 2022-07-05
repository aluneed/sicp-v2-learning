#lang scheme

;;; exercise 2.27 ;;;

#|
树反转
2.18中用了递归计算过程  
如果用迭代计算过程, 在这里改写可能会更容易?  
|#
; (define (deep-reverse tree)
;     (cond
;         ((null? tree) tree)
;         ((pair? tree)
;             (if (null? tree)
;                 tree
;                 (append
;                     (deep-reverse (cdr tree))
;                     (deep-reverse (car tree))
;                 )
;             )
;         )
;         (else (list tree))
;     )
; )

#|
出现问题
debug发现原因在于: (pair? '())结果为#f, 也就是说空列表并不是pair类型  
因此在上面的代码中因为`(else (list tree))`而被套上了又一层list包装 
加上`((null? tree) tree)`判断后, 又丢失了嵌套的层级结构  

在下一题中倒是排上用场了
|#

#|
重新理一下思路  
deep-reverse是这样一种过程: 
它总是返回一颗和原有的树左右颠倒的树  
输入'()时, 它返回'()  
输入一个list时, 它返回处理后的list  
输入一个value时, 它返回(list value), 以便append操作  
输入一个作为元素的list时, 它的返回同样应该被list包装一层, 以免append时丢失嵌套层级  

(define (deep-reverse tree)
    (cond
        ((null? tree) tree)
        ((pair? tree)
            (append
                (deep-reverse (cdr tree))
                (list (deep-reverse (car tree)))
            )
        )
        (else tree)
    )
)

最后由(pair? '())为#f, 1,3分支可以合并, cond也可以改成if, 得到最终结果
|#

(define (deep-reverse tree)
    (if (pair? tree)
        (append
            (deep-reverse (cdr tree))
            (list (deep-reverse (car tree)))
        )
        tree
    )
)
(define x (list (list 1 2) (list 3 4)))
(deep-reverse x)

#|
不得不承认, 最终形式和练习2.18如出一辙  

易错点在于
deep-reverse通过`pair?`判别输入为list有两种情况  
一种是cdr处理的结果, 必然是list或'()
另一种是car可能得到的一个作为元素的list  

之前凭直觉写下来的代码之所以造成嵌套层级关系丢失  
就是因为对这两种情况的list做了统一的处理, 而对'()和value做另一种处理  
实际上应该对'(), value和作为当前层级元素的list做一种处理(即再包裹一层list)  
对cdr所得的同级list不做包裹处理

感觉这玩意儿这么复杂  
就是因为欠缺类型系统(在这道题里欠缺)  
没有通过容器类型进行封装  
对树结构的操作和对值的操作没有分离  
将值放在一个Node的value字段中, 子树放在List<Node>中, 会让事情轻松很多
|#
