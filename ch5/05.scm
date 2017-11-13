a is cup
l is ((coffee) cup ((tea) cup) (and (hick)) cup)
(rember* a l) is ((coffee) ((tea)) (and (hick)))

a is sauce
l is (((tomato sauce)) ((bean) sauce) (and ((flying)) sauce))
(rember a l) is (((tomato)) ((bean)) (and ((flying))))

the function rember*
(define rember*
  (lambda (a l)
  	(cond
  		((null? l) (quote()))
  		((atom? (car l))
  			(cond
  				((eq? (car l) a) (rember* a (cdr l)))
  				(else (cons (car l) (rember* a (cdr l))))))
  		(else (cons (rember* a (car l)) (rember* a (cdr l)))))))

l is (((tomato sauce)) ((bean) sauce) (and ((flying)) sauce))
(lat? l) is #f

l is (((tomato sauce)) ((bean) sauce) (and ((flying)) sauce))
(car l) is not atom

new is roast
old is chuck
l is ((how much (wood))
			could 
			((a (wood) chuck)) 
			(((chuck))) 
			(if (a) ((wood chuck))) 
			could chuck wood)
(insertR* new old l) is ((how much (wood))
												 could 
												 ((a (wood) chuck roast)) 
												 (((chuck roast))) 
												 (if (a) ((wood chuck roast))) 
												 could chuck roast wood)

the function insertR*
(define insertR*
	(lambda (new old l)
		(cond
			((null? l) (quote()))
			((atom? (car l))
				(cond
					((eq? (car l) old) 
						(cons old 
							(cons new (insertR* new old (cdr l)))))
					(else (cons (car l) (insertR* new old (cdr l))))))
			(else (cons (insertR* new old (car l)) 
							(insertR* new old (cdr l)))))))

insertR* and rember* ask 3 questions

; The First Commandment
; (final version)
; When recurring on a list of atoms, lat,
; ask two questions about it: (null? lat) and else.
; When recurring on a number, n,
; ask two questions about it: (zero? n) and else
; When resurring on a list of S-expressions, l,
; ask 3 question about it: (null? l), (atom? (car l)), and else

insertR* and rember* are similar
if car is a list, recur the car and cdr

all *-functions are similar
ask 3 questions
if car is a list, recur the car and cdr

all *-functions work on lists that are either
  - empty
  - an atom consed onto a list, or
  - a list consed onto a list

; The Fourth Commandment
; (final version)
; Always change at least one argument while recurring.
; When recurring on a list of atoms, lat, use (cdr lat).
; When recurring on a number, n, use (sub1 n).
; And When recurring on a list of S-expressions, l, 
; use (car l) and (cdr l) if neither (null? l) nor (atom? (car l)) are true.
; 
; It must be changed to be closer to termination.
; The changing argument must be tested in the termination condition:
; when using cdr, test termination with null? and
; when using sub1, test termination with zero?.

a is banana
l is ((banana)
			(split ((((banana ice))) (cream (banana)) sherbet))
			(banana)
			(bread)
			(banana brandy))
(occur* a l) is 5

the function occur*
(define occur*
	(lambda (a l)
		(cond
			((null? l) 0)
			((atom? (car l))
				(cond
					((eq? (car l) a)
						(add1 (occur* a (cdr l))))
					(else (occur* a (cdr l)))))
			(else (加 (occur* a (car l)) (occur* a (cdr l)))))))

new is orange
old is banana
l is ((banana)
			(split ((((banana ice))) (cream (banana)) sherbet))
			(banana)
			(bread)
			(banana brandy))
(subst* a l) is ((orange)
								 (split ((((orange ice))) (cream (orange)) sherbet))
								 (orange)
								 (bread)
								 (orange brandy))

(define subst*
	(lambda (new old l)
		(cond
			((null? l) (quote ()))
			((atom? (car l))
				(cond
					((eq? (car l) old)
						(cons new (subst* new old (cdr l))))
					(else (cons (car l) (subst* new old (cdr l))))))
			(else (cons (subst* new old (car l)) (subst* new old (cdr l)))))))

new is pecker
old is chuck
l is ((how much (wood))
			could 
			((a (wood) chuck)) 
			(((chuck))) 
			(if (a) ((wood chuck))) 
			could chuck wood)
(insertL* new old l) is ((how much (wood))
												 could 
												 ((a (wood) pecker chuck)) 
												 (((perker chuck))) 
												 (if (a) ((wood pecker chuck))) 
												 could pecker chuck wood)

the function insertL*
(define insertR*
	(lambda (new old l)
		(cond
			((null? l) (quote()))
			((atom? (car l))
				(cond
					((eq? (car l) old) 
						(cons new 
							(cons old (insertL* new old (cdr l)))))
					(else (cons (car l) (insertL* new old (cdr l))))))
			(else (cons (insertL* new old (car l)) 
							(insertL* new old (cdr l)))))))

a is chips
l is ((potato) (chips ((with) fish) (chips)))
(member* a l) is #t

the function member*
(define insertR*
	(lambda (a l)
		(cond
			((null? l) #f)
			((atom? (car l))
				(or (eq? (car l) a) (member* a (cdr l))))
			(else (or (member* a (car l)) 
							(member* a (cdr l)))))))

l is ((potato) (chips ((with) fish) (chips)))
(leftmost l) is potato

l is (((hot) (tuna (and))) cheese)
(leftmost l) is hot

l is (((() four)) 17 (seventeen))
(leftmost l) is no answer

(leftmost (quote())) is no answer

leftmost finds the leftmost atom 
in a non-empty list of S-expressions
that does not contain the empty list

leftmost is not a *-function
it only recurs on the car
it only needs to ask two questions

the function leftmost*
(define insertR*
	(lambda (a l)
		(cond
			((atom? (car l)) (car l))
			(else (leftmost (car l))))))

x is pizza
l is (mozzarella pizza)
(and (atom? (car l)) (eq? (car l) x)) is #f

x is pizza
l is ((mozzarella mushroom) pizza)
(and (atom? (car l)) (eq? (car l) x)) is #f

x is pizza
l is (pizza (tastes good))
(and (atom? (car l)) (eq? (car l) x)) is #t

l1 is (strawberry ice cream)
l2 is (strawberry ice cream)
(eqlist? l1 l2) is #t

l1 is (strawberry ice cream)
l2 is (strawberry cream ice)
(eqlist? l1 l2) is #f

l1 is (banana ((split)))
l2 is ((banana) (split))
(eqlist? l1 l2) is #f

l1 is (beef ((sausage)) (and (soda)))
l2 is (beef ((salami)) (and (soda)))
(eqlist? l1 l2) is #f

l1 is (beef ((sausage)) (and (soda)))
l2 is (beef ((sausage)) (and (soda)))
(eqlist? l1 l2) is #t

eqlist? have to ask 9 questions about its arguments
each argument may be either
 - empty
 - an atom consed onto a list, or
 - a list consed onto a list

write eqlist? using eqan?
(define eqlist?
	(lambda (l1 l2)
		(cond
			((and (null? l1) (null? l2)) #t)
			((and (null? l1) (atom? (car l2))) #f)
			((null? l1) #f)
			((and (atom? (car l1)) (null? l2)) #f)
			((and (atom? (car l1)) (atom? (car l2)))
				(and (eqan? (car l1) (car l2)) 
					(eqlist? (cdr l1) (cdr l2))))
			((atom? (car l1)) #f)
			((null? l2) #f)
			((atom? (car l2)) #f)
			(else
				(and (eqlist? (car l1) (car l2))
					(eqlist? (cdr l1) (cdr l2)))))))

; The Sixth Commandment
; Simplify only after the function is correct