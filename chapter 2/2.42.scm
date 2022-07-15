#lang scheme

(define (enumerateInterval low high)
    (if (> low high)
        '()
        (cons low (enumerateInterval (+ low 1) high))
    )
)
(define (accumulate accumulator initial sequence)
    (if (null? sequence)
        initial
        (accumulator
            (car sequence)
            (accumulate accumulator initial (cdr sequence))
        )
    )
)
(define (flatmap func sequence)
    (accumulate append '() (map func sequence))
)

;;; exercise 2.42 ;;;  经典八皇后

(define (queens boardSize)
    (define (queenColumns k)
        (if (= k 0)
            (list emptyBoard)  ;;空的格局集合
            (filter 
                (lambda (positions)
                    (safe? k positions)  ;;确保新加入的第k列符合行列对角线规则  
                )
                (flatmap
                    (lambda (restOfQueens)  ;;restOfQueens 前k-1列放置k-1个皇后的一种方式
                        (map
                            (lambda (newRow)
                                (adjoinPosition newRow k restOfQueens)  ;;将新的行列格局加入格局集合
                            )
                            (enumerateInterval 1 boardSize)
                        )
                    )
                    (queenColumns (- k 1))
                )
            )
        )
    )
    (queenColumns boardSize)
)

;;注意到题目和代码中的`(enumerateInterval 1 boardSize)`, 可以看出这种遍历方式是逐行新增的, 而非解决k-1皇后问题再进行组合  

(define emptyBoard '(() () () () ...))

(define (adjoinPosition newRow k restOfQueens)  ;;给已知的k-1布局集合中的每个元素都加上新的列 restOfQueens {matrix1, matrix2, ...}
    (map
        (lambda (layout)  ;;'((0..0) (0..0)..(0..0))
            (define (add layout i)
                (if (> i k)
                    '()
                    (if (= i newRow)
                        (cons (cons 1 (car layout)) (add (cdr layout) (+ i 1)))
                        (cons (cons 0 (car layout)) (add (cdr layout) (+ i 1)))
                    )
                )
            )
            (add layout 1)
        )
        restOfQueens
    )
)
; (define layoutTest '((0 0 0)(0 0 0)(0 0 0)(0 0 0)(0 0 0)(0 0 0)(0 0 0)(0 0 0)))
; (adjoinPosition 3 8 (list layoutTest))
; (adjoinPosition 3 8 '((() () () () () () () ())))

;;layout处理的草稿代码
; (define (add layout newRow k)
;     (if (null? layout)
;         '()
;         (if (= k newRow)
;             (cons (cons 1 (car layout)) (add (cdr layout) newRow (- k 1)))
;             (cons (cons 0 (car layout)) (add (cdr layout) newRow (- k 1)))
;         )
;     )
; )
; (define layoutTest '((0 0 0)(0 0 0)(0 0 0)(0 0 0)(0 0 0)(0 0 0)(0 0 0)(0 0 0)))
; (add layoutTest 3 8)

;;第k列满足八皇后规则的判定, 难点在于对角线处理  
;;这里虽然将规则检验和新增列解耦, 但是新增列时其实就已经可以过滤掉一些不正确的行号  
;;(if (= k 1))情况直接返回#t

(define (safe? k positions)
    (let (rowIndex (check k 0 positions))
        (if (rowIndex)  ;;数值类型会被判定为#t
            ()
            #f
        )
    )
)

(define (checkUp k rowIndex layout)
    
)

(define (check k row layout)
    (cond
        ((not (null? layout))
            (if (= (listGet (car layout) (- k 1)) 1)  ;;列k的行row处为1
                (if (= (accumulate + (car layout)) 1)  ;;如果列中和为1
                    row
                    #f
                )
                (check k (+ row 1) (cdr layout))
            )
        )
        (else #f)
    )
)
; (define positionTest '((0 0) (0 0) (1 0) (0 0) (0 0) (0 0) (0 1) (0 0)))
; (check 2 1 positionTest)
; (check 2 0 positionTest)
; (listGet positionTest 2)

(define (listGet items index)
    (if (= index 0)
        (car items)
        (listGet (cdr items) (- index 1))
    )
)
; (listGet '(1 2 3 4 5) 4)  ;;5


;;没有类型系统时, 语义可读性真的很弱, 不得不用注释去标记数据的结构  
;;闭包性质确实能使得一种结构就能应对很多问题, 但在语义上非常难以理解  
;;在小范围的代码处理上也没有过程式语言方便  