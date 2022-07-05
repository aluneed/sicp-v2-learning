#lang scheme

;;; exercise 2.32 ;;;

#|
幂集问题

subsets是这样一个过程: 
输入一个以list组织的集合, 返回它的幂集
它可以这样被拆分:
假设集合并集运算为+, 求集合的幂集运算为ps()
{1,2} -> {{},{1},{2},{1,2}}
{1,2,3} -> {{},{1},{2},{1,2},{3},{1,3},{2,3},{1,2,3}}
        -> {{},{1},{2},{1,2}} + {{},{1},{2},{1,2}} * {3} 
这里还定义了一种新运算*, 表示在集合中的每个集合元素中后面都加上另一个集合中的元素  
那么S = {a} + REST
ps(S) = {a} + ps(REST) + (ps(REST) - {{}}) * {a}  (这里的ps(REST) - {{}}其实语义并不太明确, 大概就是不对空集在做处理吧, 当然从前面的实例来看也可以一并处理, 但不额外增加{a})
ps({a} + REST) = ps(REST) + ps(REST) * {a}

这部分想清楚之后, lambda写起来很轻松
|#

(define (subsets s)
    (if (null? s)
        (list '())
        (let ((rest (subsets (cdr s))))
            (append
                rest
                (map
                    (lambda (element-list) (cons (car s) element-list))
                    rest
                )
            )
        )
    )
)

(subsets '(1 2 3))
