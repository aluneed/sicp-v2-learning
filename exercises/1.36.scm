#lang scheme

;;; exercise 1.36 ;;;

(define (fixedPoint f x tolerance) (
    if (< (abs (- (f x) x)) tolerance)
        x
        (fixedPoint f (/ (+ x (f x)) 2) tolerance)
))

#|test
(fixedPoint (lambda (x) (+ 1 (/ x))) 1.0 0.000000001)
|#

(define (visualFixedPoint f x tolerance counter)
    (display "x = ")
    (display x)
    (display ", counter = ")
    (display counter)
    (newline)
    (if (< (abs (- (f x) x)) tolerance)
        x
        (visualFixedPoint f (/ (+ x (f x)) 2) tolerance (+ counter 1))
    )
)

#|test
(visualFixedPoint (lambda (x) (+ 1 (/ x))) 1.0 0.000000001 1)
|#

;;4^4=256, 5^5=625*5
(visualFixedPoint (lambda (x) (/ (log 1000) (log x))) 4.0 0.000000001 1)
#|
x = 4.0, counter = 1
x = 4.491446071165521, counter = 2
x = 4.544974650975552, counter = 3
x = 4.553746974742814, counter = 4
x = 4.555231425802502, counter = 5
x = 4.555483906560562, counter = 6
x = 4.5555268862194875, counter = 7
x = 4.5555342036887705, counter = 8
x = 4.555535449549851, counter = 9
x = 4.55553566166914, counter = 10
x = 4.555535697784423, counter = 11
x = 4.555535703933387, counter = 12
x = 4.555535704980304, counter = 13
4.555535704980304
|#

#|
(define (visualFixedPoint f x tolerance counter)
    (display "x = ")
    (display x)
    (display ", counter = ")
    (display counter)
    (newline)
    (if (< (abs (- (f x) x)) tolerance)
        x
        (visualFixedPoint f (f x) tolerance (+ counter 1))
    )
)
(visualFixedPoint (lambda (x) (/ (log 1000) (log x))) 4.0 0.000000001 1)
|#

#|
x = 4.0, counter = 1
x = 4.9828921423310435, counter = 2
x = 4.301189432497896, counter = 3
x = 4.734933901055578, counter = 4
x = 4.442378437719526, counter = 5
x = 4.632377941509958, counter = 6
x = 4.505830646780212, counter = 7
x = 4.588735606875766, counter = 8
x = 4.533824356566501, counter = 9
x = 4.56993352418142, counter = 10
x = 4.546075272637246, counter = 11
x = 4.561789745175654, counter = 12
x = 4.55141783665413, counter = 13
x = 4.5582542120702625, counter = 14
x = 4.553744140202578, counter = 15
x = 4.556717747893265, counter = 16
x = 4.554756404545319, counter = 17
x = 4.5560497413912975, counter = 18
x = 4.5551967522618035, counter = 19
x = 4.555759257615811, counter = 20
x = 4.555388284933278, counter = 21
x = 4.555632929754932, counter = 22
x = 4.555471588998784, counter = 23
x = 4.555577989320218, counter = 24
x = 4.555507819903776, counter = 25
x = 4.555554095154945, counter = 26
x = 4.555523577416557, counter = 27
x = 4.555543703263474, counter = 28
x = 4.555530430629037, counter = 29
x = 4.555539183677709, counter = 30
x = 4.5555334112028065, counter = 31
x = 4.555537218041141, counter = 32
x = 4.5555347075017965, counter = 33
x = 4.55553636315543, counter = 34
x = 4.555535271282659, counter = 35
x = 4.555535991352336, counter = 36
x = 4.555535516479803, counter = 37
x = 4.5555358296493695, counter = 38
x = 4.55553562311988, counter = 39
x = 4.555535759322224, counter = 40
x = 4.555535669499318, counter = 41
x = 4.5555357287358484, counter = 42
x = 4.555535689670462, counter = 43
x = 4.555535715433355, counter = 44
x = 4.555535698443208, counter = 45
x = 4.555535709647893, counter = 46
x = 4.555535702258612, counter = 47
x = 4.555535707131705, counter = 48
x = 4.555535703917991, counter = 49
x = 4.555535706037376, counter = 50
x = 4.555535704639682, counter = 51
4.555535704639682
|#