14 is atom
all numbers are atoms

n is 14
(atom? n) is true

-3 is a number
but negative numbers go away

3.14159 is a number
but whole numbers only

-3 and 3.14159 are numbers
but we only use 0, 1, 2, 3, ...

n is 67
(add1 n) is 68

(add1 67) is 68

n is 5
(sub1 n) is 4

(sub1 0) no answer
consider only nonnegative numbers

(zero? 0) is True

(zero? 1492) is False

(加 46 12) is 58

the function 加
(define 加
  (lambda (n m)
  	(cond
  	  ((zero? m) n)
  		(else (add1 (加 n (sub1 m)))))))

zero? asks if a number is empty
null? adks if a list is empty

add1 builds numbers
cons builds lists

(减 14 3) is 11

(减 17 9) is 8

(减 18 25) is no answer
there are no negative numbers

the function 减
(define 减
	(lambda (n m)
		(cond
			((zero? m) n)
			(else (sub1 (减 n (sub1 m)))))))

(2 11 3 79 47 6) is tup
tup is short for tuple

(8 55 5 555) is tup
it's a list of numbers

(1 2 8 apple 4 3) is not a tup
it's a list of atoms

(3 (7 4) 13 9) is not a tup
it's not a list of numbers
(7 4) is not a number

() is a tup
it's a empty tup
it's a list of zero numbers

tup is (3 5 2 8)
(addtup tup) is 18

tup is (15 6 7 12 3)
(addtup tup) is 43

addtup builds a number by totaling all the numbers in tup

加 builds numbers as cons builds lists

when building lists with cons
the value of the terminal condition is ()
when building numbers with 加
the value of the terminal condition is 0

the natural terminal condition for a list is (null? l)
the natural terminal condition for a tup is (null? tup)

the terminal condition line for a list is ((null? l) (quote()))
the terminal condition line for a tup is ((null? tup) 0)

a lat either an empty list
or it contains an atom -- (car lat)
and a rest -- (cdr lat) -- also a lat

a tup either an empty list
for it contains a number -- (car tup)
and a rest -- (cdr tup) -- also a tup

recur with (cdr lat) in a list
cause the rest of a non-empty list is a list
recur with (cdr tup) in a tup
cause the rest of a non-empty tup is a tup

; The First Commandment
; first revision
; When recurring on a list of atoms, lat,
; ask two questions about it: (null? lat) and else.
; When recurring on a number, n,
; ask two questions about it: (zero? n) and else.

the function addtup
(define addtup
	(lambda (tup)
		(cond
			((null? tup) 0)
			(else (加 (car tup) (addtup (cdr tup)))))))

(× 5 3) is 15

(× 13 4) is 15

(× n m) builds up a number by adding n up m times

the terminal condition line for × is ((zero? m) 0)

since (zero? m) is the terminal condition
m must eventually be reduced to zero
sub1 is used to do this

; The Fourth Commandment
; first revison
; Always change at least one argument while recurring.
; It must be changed to be closer to termination.
; The changing argument must be tested in the termination condition:
; when using cdr, test termination with null?
; when using sub1, test termination with zero?

×'s natural recursion is (× n (sub1 m))

the function ×
(define ×
	(lambda (n m)
		(cond
			((zero? m) 0)
			(else (加 n (× n (sub1 m)))))))

(× 12 3) is 36

(zero? m) is false

the meaning of (加 n (× n (sub1 m)))
add n to the recursion

n is 12
m is 2

(zero? m) is false

the meaning of (加 n (× n (sub1 m)))
add n to the recursion

n is 12
m is 1

(zero? m) is false

the meaning of (加 n (× n (sub1 m)))
add n to the recursion

n is 12
m is 0

(zero? m) is true
((zero? m) 0) is 0

add 12 to 12 to 12 to 0 yielding 36

argue using equation
(× 12 3) = 12 加 (× 12 2)
				 = 12 加 12 加 (× 12 1)
				 = 12 加 12 加 12 加 (× 12 0)
				 = 12 加 12 加 12 加 0
this technique works for all recursive functions

; The Fifth Commandment
; When building a value with 加, 
; always use 0 for the value of the termination line,
; for adding 0 does not change the value of an addition.
; When building a value with ×, 
; always use 1 for the value of the terminating line,
; for multiplying by 1 does not change the value of a multiplication.
; When building a value with cons,
; always consider () for the value of the terminating line.

tup1 is (3 6 9 11 4)
tup2 is (8 5 2 0 7)
(tup加 tup1 tup2) is (11 11 11 11 11)

tup1 is (2 3)
tup2 is (4 6)
(tup加 tup1 tup2) is (6 9)

when recurring on a tup
we ask two question, (null? tup) and else

when recurring on two tups
we ask four question, (null? tup1) and else, (null? tup2) and else

the function tup加
(define tup加
	(lambda (tup1 tup2)
		(cond
			((and (null? tup1) (null? tup2)) (quote()))
			(else
				(cons (加 (car tup1) (car tup2)) 
							(tup加 (cdr tup1) (cdr tup2)))))))

tup1 is (3 7)
tup2 is (4 6)
(tup加 tup1 tup2) is (7, 13)

(null? tup1) is false

cons 7 onto the recursion: (tup加 (cdr tup1) (cdr tup2))

tup1 is (7)
tup2 is (6)

(null? tup1) is false

cons 13 onto the recursion: (tup加 (cdr tup1) (cdr tup2))

tup1 is ()
tup2 is ()

(and (null? tup1) (null? tup2)) is true
the value is ()

the value of the application
the cons of 7 onto the cons of 13 onto () is (7 13)

tup1 is (3 7)
tup2 is (4 6 8 1)
(tup加 tup1 tup2) no answer
but we wish the final value to be (7 13 8 1)

the new function tup加
(define tup加
	(lambda (tup1 tup2)
		(cond
			((and (null? tup1) (null? tup2)) (quote()))
			((null? tup1) tup2)
			((null? tup2) tup1)
			(else
				(cons (加 (car tup1) (car tup2)) 
							(tup加 (cdr tup1) (cdr tup2)))))))

the new simple function tup加
(define tup加
	(lambda (tup1 tup2)
		(cond
			((null? tup1) tup2)
			((null? tup2) tup1)
			(else
				(cons (加 (car tup1) (car tup2)) 
							(tup加 (cdr tup1) (cdr tup2)))))))

(> 12 133) is #f

(> 120 11) is #t

(> n m)
wo have to recur n and m

recur with (sub1 n) and (sub1 m)
when neither number is equal to 0

we have to ask 3 questions
(zero? n) (zero? m) else

the function >
(define >
	(lambda (n m)
		(cond
			((zero? m) #t)
			((zero? n) #f)
			(else (> (sub1 n) (sub1 m))))))

n is 3
m is 3
(> n m) is true, of course is wrong

no switch the zero? line:
(define >
	(lambda (n m)
		(cond
			((zero? n) #f)
			((zero? m) #t)
			(else (> (sub1 n) (sub1 m))))))

(< 4 6) is #t

(< 8 3) is #f

(< 6 6) is #f

the function <
(define <
	(lambda (n m)
		(cond
			((zero? m) #f)
			((zero? n) #t)
			(else (< (sub1 n) (sub1 m))))))

the function =
(define =
	(lambda (n m)
		(cond
			((> n m) #f)
			((< n m) #f)
			(else #t))))

(↑ 1 1) is 1

(↑ 2 3) is 8

(↑ 5 3) is 125

the function ↑
(deine ↑
	(lambda (n m)
		(cond
			((zero? m) 1)
			(else (× n (↑ n (sub1 m)))))))

the function ÷
(define ÷
	(lambda (n m)
		(cond
			((< n m) 0)
			(else (add1 (÷ (- n m) m))))))

÷ counts how many times m fits into n

(÷ 15 4) is 3

(÷ 15 4) = 1 + (÷ 11 4)
         = 1 + 1 + (÷ 7 4)
         = 1 + 1 + 1 + (÷ 3 4)
         = 1 + 1 + 1 + 0

lat is (hotdogs with mustard sauerkraut and pickles)
(length lat) is 6

lat is (ham and cheese on rye)
(length lat) is 5

the function length
(define length
	(lambda (lat)
		(cond
			((null? lat) 0)
			(else (add1 (length(cdr lat)))))))

n is 4
lat is (lasgna spaghetti ravioli macaroni meatball)
(pick n lat) is macaroni

lat is (a)
(pick 0 lat) no answer

the function pick
(define pick
	(lambda (n lat)
		(cond
			((zero? (sub1 n)) (car lat))
			(else (pick (sub1 n) (cdr lat))))))

n is 3
lat is (hotdogs with hot mustard)
(rempick n lat) is (hotdogs with mustard)

the function rempick
(define rempick
	(lambda (n lat)
		(cond
			((zero? (sub1 n)) (cdr lat))
			(else (cons (car lat) (rempick (sub1 n) (cdr lat)))))))

a is tomato
(number? a) is false

(number? 76) is true

lat is (5 pears 6 prunes 9 dates)
(no-nums lat) is (pears prunes dates)

the function no-nums
(define no-nums
	(lambda (lat)
		(cond
			((null? lat) (quote()))
			(else 
				(cond
					((number? (car lat)) (no-nums (cdr lat)))
					(else (cons (car lat) (no-nums (cdr lat)))))))))

lat is (5 pears 6 prunes 9 dates)
(all-nums lat) is (5 6 9)

the function alll-nums
(define all-nums
	(lambda (lat)
		(cond
			((null? lat) (quote()))
			(else 
				(cond
					((number? (car lat)) (cons (car lat) (all-nums (cdr lat))))
					(else (all-nums (cdr lat))))))))

= for numbers
eq? for all other atoms
eqan? for all atoms

the function eqan?
(define eqan?
	(lambda (a1 a2)
		(cond
			((and (number? a1) (number? a2)) (= a1 a2))
			((or (number? a1) (numb1? a2)) #f)
			(else (eq? a1 a2)))))

the function occur counts the number of times an atom a appears in a lat
(define occur
	(lambda (a lat)
		(cond
			((null? lat) 0)
			(else
				(cond
					((eqan? (car lat) a) (add1 (occur a (cdr lat))))
					(else (occur a (cdr lat))))))))

the function one?
(define one?
	(lambda (n)
		(cond
			(else (= n 1)))))

the simple one?
(define one?
	(lambda (n)
		(= n 1)))

rewrite the function rempick

the old rempick
(define rempick
	(lambda (n lat)
		(cond
			((zero? (sub1 n)) (cdr lat))
			(else (cons (car lat) (rempick (sub1 n) (cdr lat)))))))

the new rempick
(define rempick
	(lambda (n lat)
		(cond
			((one? n) (cdr lat))
			(else (cons (car lat) (rempick (sub1 n) (cdr lat)))))))