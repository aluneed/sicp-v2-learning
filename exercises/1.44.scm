#lang scheme

;;; exercise 1.44 ;;;

(define dx 1)
(define (smooth f)
    (lambda (x) (
        / (+ (f x) (f (+ x dx)) (f (- x dx))) 3
    ))
)

(define (repetitiveSmooth f k) (
    if (= k 0)
        f
        (repetitiveSmooth (smooth f) (- k 1))
))

(define (f x) (* x x))
((repetitiveSmooth sqrt 5) 5.0)
(sqrt 5.0)
((repetitiveSmooth f 5) 5.0)
(f 5.0)
;;主要问题在于效果难以验证

;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
(define (repeat f times)
    if (= times 1)
        f
        (repeat (lambda (compose f0 f)) (- times 1))
        ;;这里很容易看出, compose会组合需要重复times次数的变换f0, 以及当前所得的变换结果f
        ;;在f0无法显示在代码中写出时, 就需要通过参数传递或外部引用(let或内部define)来获取
        ;;上面的repetitiveSmooth不需要传递f0就是因为f0对应的是smooth过程, 而这一过程被显示地写在了代码里, 不需要再通compose去嵌套smooth和f
        ;;只需要通过f不断传递这一次计算通过smooth处理后所得到的f', 作为下一次计算的f
)
|#

(define (smoothCompose f k)
    (define (iterator f times result) (
        if (= times 0)
            result
            (iterator f (- times 1) (smooth result))
    ))
    (iterator f k f)
)
((smoothCompose sqrt 5) 5.0)
(sqrt 5.0)
((smoothCompose f 5) 5.0)
(f 5.0)

;;;;;;;;;;;;;;;;;;;;;;;;;

(define (compose f g) 
    (lambda (x) (
        f (g x)
    ))
)
(define (repeat f times)
    (define (iterator f times resultFunction) (
        if (= times 1)
            resultFunction
            (iterator f (- times 1) (compose f resultFunction))
    ))
    (iterator f times f)
)
(((repeat smooth 5) f) 5.0)  ;;要点在于, smooth重复5次之后, 输入参数不是一个数字, 而是函数f, 最终5次smooth平滑f后所得的函数对5.0求值