#lang scheme

;;; exercise 2.28 ;;;

#|
在开始实现前, 可以先假定 
fringe是这样一种方法: 
它总是返回一棵树的左序叶子节点list
当输入'()时, 它返回'()
当输入一个值value时, 它返回(list value)
|#

(define (fringe tree)
    (cond 
        ((null? tree) '())
        ((pair? tree)
            (append (fringe (car tree)) (fringe (cdr tree)))
        )
        (else (list tree))
    )
)

(define x (list (list 1 2) (list 3 4)))
(fringe x)  ;;(1 2 3 4)
(fringe (list x x))  ;;(1 2 3 4 1 2 3 4)

;;(null? 1) -> #f
;;这是合法的
;;相比于2.27, 无需维持层级结构, 反而更简单了

;;发现了`cond`中谓词逻辑和结果表达式的不错写法
#|
(<p>
    <e>
    <e>
    ...
)
|#