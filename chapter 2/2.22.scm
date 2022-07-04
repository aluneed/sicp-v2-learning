#lang scheme

;;; exercise 2.22 ;;;

(define (square-list items)
    (define (iter input output)
        (if (null? input)
            output
            (iter 
                (cdr input)
                (append output (list (sqr (car input))))
            )
        )
    )
    (iter items '())
)
(square-list '(1 2 3 4 5))

#|
没啥好说的  
使用cons进行递归总是从list头部开始取元素  
但不会立即进行变换, 而是存在调用栈中  
直到递归到队尾开始返回时, 才会一层层变换再加入新的list头部  

在迭代过程中, 则从一开始就新建了一个'()空列表, 每次迭代都向其头部加入一个变换后的元素  
不幸的是这个元素是从输入list的头部取出的, 会之间被压至新list的末尾

修正后的程序则输出`(((((() . 1) . 4) . 9) . 16) . 25)`这样的结果

cons的实际过程是将第一个参数放进一个元组的左值, 再将元组的右值设置为第二个参数的引用  
当第一个参数是元组时, 不会有任何影响(此时list的结构不变)
`(cons '(0 1) '(2 3))`也同样能得到`((0 1) 2 3)`的结果, 只是第一个元素变成了元组, 整体仍然是list
当第二个参数不是list时, 无论如何都无法构成新的list
因为cons的结果无论如何都会因为第二个非list参数作为右值, 而必然不是list
|#
