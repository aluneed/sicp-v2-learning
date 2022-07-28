#lang scheme

;;优化策略: 将验证结果作为累计值记录在matrix中; 不再多次验证row和对角线, 而是记录占位再在加入时检测  

(define (enumerateInterval low high)
    (if (> low high)
        '()
        (cons low (enumerateInterval (+ low 1) high))
    )
)
;;(enumerateInterval 0 8)  ;;(0 1 2 3 4 5 6 7 8)
(define (accumulate accumulator initial sequence)
    (if (null? sequence)
        initial
        (accumulator
            (car sequence)
            (accumulate accumulator initial (cdr sequence))
        )
    )
)
;;(accumulate + 0 '(1 2 3 4 5))  ;;15
(define (flatmap func sequence)
    (accumulate append '() (map func sequence))
)

(define emptyBoard '(() () () () () ()))

(define (queens boardSize)
    (define (queenColumns k)
        (if (= k 0)
            (list emptyBoard)  ;;空的格局集合
            (filter  ;;自带函数 
                (lambda (positions)
                    (safe? k positions)  ;;确保新加入的第k列符合行列对角线规则  
                )
                (let ((results (flatmap
                    (lambda (newRow)
                        (map
                            (lambda (restOfQueens)  ;;restOfQueens 前k-1列放置k-1个皇后的一种方式
                                (adjoinPosition newRow k restOfQueens)  ;;将新的行列格局加入格局集合
                            )
                            (queenColumns (- k 1))
                        )
                    )
                    (enumerateInterval 1 boardSize)  ;;枚举[1,boardSize]
                )))
                    (print (length results))
                    (newline)
                    results
                )
            )
        )
    )
    (queenColumns boardSize)
)

#|
交换顺序之后语义并不明确, 因此打印信息进行测试
可以看出交换顺序之前则只执行了boardSize次数的过滤  
交换顺序后出现了大量拥有相同数量元素的list, 然后再一一对这些list执行了过滤  
只有最后结束前的过滤的6个list元素数量和交换前吻合  

从直觉上来看, 顺序交换导致从dfs变成了bfs, 对每一个(k-1)的布局, 后续的rowIndex组合都会被测试一遍  
filter进行过滤的次数是n^n, 递归遍历的结果也可以看作一个完全n叉树  
而不交换的情况进行dfs, 则会对递归过程构成的n叉树进行剪枝, 最终得到n*n布局时就已经是递归的叶子节点  
也可以在遍历决策树的角度来看这个递归过程  
|#

(define (safe? k matrix)  ;;k不是columnIndex
    (let ((columnIndex (- k 1))(rowIndex (checkRow 0 (- k 1) matrix)))
        (if rowIndex
            (and
                (checkDiagonalUp (- rowIndex 1) (- columnIndex 1) matrix) 
                (checkDiagonalDown (+ rowIndex 1) (- columnIndex 1) matrix)
            )
            #f
        )
    )
)
(define (checkDiagonalUp rowIndex columnIndex matrix)
    (cond
        ((or (< rowIndex 0) (< columnIndex 0))
            #t
        )
        ((= 1 (getByIndex (getByIndex matrix rowIndex) columnIndex))
            #f
        )
        (else (checkDiagonalUp (- rowIndex 1) (- columnIndex 1) matrix))
    )
)
(define (checkDiagonalDown rowIndex columnIndex matrix)
    (cond
        ((or (>= rowIndex (length matrix)) (< columnIndex 0))
            #t
        )
        ((= 1 (getByIndex (getByIndex matrix rowIndex) columnIndex))
            #f
        )
        (else (checkDiagonalDown (+ rowIndex 1) (- columnIndex 1) matrix))
    )
)

(define (checkRow rowIndex columnIndex matrix)
    (cond
        ((null? matrix)
            #f
        )
        ((= (getByIndex (car matrix) columnIndex) 1)
            (if (> (accumulate + 0 (car matrix)) 1)
                #f
                rowIndex
            )
        )
        (else (checkRow (+ 1 rowIndex) columnIndex (cdr matrix)))
    )
)
;;(define mat '((1 0) (0 0) (0 1)))
;;(checkRow 0 1 mat)

(define (getByIndex dataList index)
    (if (= index 0)
        (car dataList)
        (getByIndex (cdr dataList) (- index 1))
    )
)
;;  (getByIndex '(0 1 2 3 4 5) 3)

;;rowNumber=(rowIndex+1)-加入的行号, n-列号 没用, matrix-已有的layout矩阵
(define (adjoinPosition rowNumber n matrix)
    (map
        append
        matrix
        (buildVector rowNumber (length matrix))
    )
)
(define (buildVector k n)
    (define (iter k n v)
        (if (= n 0)
            v
            (iter k (- n 1) (cons (if (= n k) '(1) '(0)) v))
        )
    )
    (iter k n '())
)

(queens 6)
