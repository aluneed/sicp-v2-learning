#lang scheme

;;; exercise 2.27 ;;;


#|
2.18中用了递归计算过程  
如果用迭代计算过程, 在这里改写可能会更容易?  
|#
(define (deep-reverse tree)
    (cond
        ((null? tree) tree)
        ((pair? tree)
            (if (null? tree)
                tree
                (append
                    (deep-reverse (cdr tree))
                    (deep-reverse (car tree))
                )
            )
        )
        (else (list tree))
    )
)

(define x (list (list 1 2) (list 3 4)))
(deep-reverse x)

#|
出现问题
debug发现原因在于: (pair? '())结果为#f, 也就是说空列表并不是pair类型  
因此在上面的代码中因为`(else (list tree))`而被套上了又一层list包装 
加上`((null? tree) tree)`判断后, 又丢失了嵌套的层级结构  
|#
