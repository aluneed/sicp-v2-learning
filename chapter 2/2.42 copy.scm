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

(define (queens boardSize)
    (define (queenColumns k)
        (if (= k 0)
            (list emptyBoard)  ;;空的格局集合
            (filter  ;;自带函数 
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

(define (safe? columnIndex matrix)
    (let ((rowIndex (checkRow 0 columnIndex matrix)))
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



;;rowNumber=(rowIndex+1)-加入的行号, n-n皇后, matrix-已有的layout矩阵
(define (adjoinPosition rowNumber n matrix)
    (map
        append
        matrix
        (buildVector rowNumber n)
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
;;(buildVector 1 8)
;;(define mat '((1 0) (0 0) (0 1) (0 0) (0 0) (0 0) (0 0) (0 0)))
;;(adjoinPosition 2 8 mat)
;;(define mat '())

