#lang scheme

;;; exercise 2.25 ;;;

#|
啥意思? 给出一种组合就行了? 还是全部?

cdr cdr car cdr
car car
cdr cdr cdr cdr cdr cdr car

这种树形结构中所需值唯一时, 应该只有一种组合  
因为不存在联通图结构
|#

;;可以递归进行查找, 然后根据查找路径输出car和cdr的组合
(define (find value branches combination)
    (cond 
        ((pair? branches)
            (find value (car branches) (string-append combination "car "))
            (find value (cdr branches) (string-append combination "cdr "))
        )
        ((null? branches) (newline) (display ""))
        ((and (not (pair? branches)) (= value branches))
            (display combination)
        )
        ;;((and (not (pair? branches)) (not (= value branches))) ())
        ;;((null? branches) ())
    )
)
(find 7 '(1 3 (5 7) 9) "")
(find 7 '((7)) "")
(find 7 '(1 (2 (3 (4 (5 (6  7)))))) "")

#|
cdr cdr car cdr car 
car car 
cdr car cdr car cdr car cdr car cdr car cdr car 

这段代码写出来测试, 才发现前面的1和3都写错了  

发生错误的错误原因在于  
哪怕cdr之后只有一个元素  
其实也没有得到想要的元素, 而是得到了包裹它的list

拼凑起来的递归程序反而更加靠谱
|#

