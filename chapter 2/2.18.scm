#lang scheme

;;; exercise 2.18 ;;;

(define (reverse data-list)
    (if (null? (car data-list))
        data-list
        (append (reverse (cdr data-list)) (list (car data-list)))
    )
)

(reverse (list 1 4 9 16 25))

;;这个递归比较精巧, 但空间消耗应该和新建一个list差不多
;;递归过程中每个栈帧中都由`(car data-list)`储存了一个值  
;;如果每次递归调用传递的是引用而非新的子列表, 那么空间消耗还是O(n)

#|
(define (reverse list)
    (if (null? list)
        list
        (append (reverse (cdr list)) (list (car list)))
    )
)

;;这种写法错误的地方在于
(append '() (25))  会报错
application: not a procedure;
expected a procedure that can be applied to arguments
given: 25
单纯从运行报错是很难发现问题的  
实际上不能在空列表`()`后面进行`append`操作  
|#

#|
(define (reverse list)
    (if (null? (cdr list))
        list
        (append (reverse (cdr list)) (list (car list)))
    )
)
这个还是有问题
改写后开始排错
(define (reverse list)
    (if (null? (cdr list))
        list
        (let (
                (listResult (reverse (cdr list)))
                (listSingle (list (car list)))  ; <- application: not a procedure; expected a procedure that can be applied to arguments - given: list
            )
            (append listResult listSingle)
        )
    )
)
最后发现是命名问题, list变量覆盖了`list`关键字
真的有点恶心
练习2.17用list做变量名没有出现问题, 大意了
|#
