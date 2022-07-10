#lang scheme

;;; exercise 2.37 ;;; 矩阵运算

(define (dot-product v w)
  (accumulate + 0 (map * v w))  ;;scheme标准提供的map 脚注78见p78  
)
