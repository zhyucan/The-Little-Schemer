(define rember
 (lambda (s l)
   (cond
    ((null? l) (quote ()))
    ((equal? (car l) s) (cdr l))
    (else (cons (car l)
                (rember s (cdr l)))))))

make rember remove the first a from (b c a)
rember(a (b c a))

make rember remove the first c form (b c a)
rember(c (b c a))

make rember-f use equal? instead of eq?
equal? as an argument to rember-f

test? is =
a is 5
l is (6 2 5 3)
(rember-f test? a l) is (6 2 3)

test? is eq?
a is jelly
l is (jelly beans are good)
(rember-f test? a l) is (beans are good)

test? is equal?
a is (pop corn)
l is (lemonade (pop corn) and (cake))
(rember-f test? a l) is (lemonade and (cake))

write rember-f
(define rember-f
	(lambda (test? a l)
		(cond
			((null? l) (quote ()))
			(else (cond
							((test? (car l) a) (cdr l))
							(else (cons (car l) 
											(rember test? a (cdr l)))))))))

the short version
(define rember-f
	(lambda (test? a l)
		(cond
			((null? l) (quote ()))
			((test? (car l) a) (cdr l))
			(else (cons (car l) 
							(rember test? a (cdr l)))))))

if test? is eq?
(rember-f test? a l) acts like rember

if test? is equal?
(rember-f test? a l) is rember with eq? replaced by equal?

rember with =
rember with equal?
rember with eq?
rember-f
the 4 functions do almost the same things

rember-f behave like all the others

functions can return lists and atoms

functions can return themselves

(lambda (a l) ...) is a function of 2 arguments, a, l

(lambda (a) (lambda (x) (eq? x a))) is a function
pass an argument a
return (lambda (x) (eq? x a))

using (define ...) give the preceding function a name
(define eq?-c
	(lambda (a)
		(lambda (x)
			(eq? x a))))

k is salad
(eq?-c k) is a function
the value takes x as an argument and tests (eq? x salad)

k is salad
(define eq?-salad (eq?-c k))

y is salad
(eq?-salad y) is #t

y is tuna
(eq?-salad y) is #f

we don't need to give a name to eq?-salad

x is salad
y is tuna
((eq?-c x) y) is #f

rewrite rember-f
(define rember-f
	(lambda (test?)
		(lambda (a l)
			(cond
				((null? l) (quote ()))
				((test? (car l) a) (cdr l))
				(else (cons (car l) 
								((rember-f test?) a (cdr l))))))))

rember-f takes one argument test?
returns an argument like rember with eq? replaced by test?

the value of (rember-f test?) where test? is eq?
it is a function
it takes 2 arguments, a and l
it compares the elements of the list with a
the first one that is eq? to a is removed

give a name to the function returned by (rember-f test?) where test? is eq?
(define removed-eq?
	(rember-f test?))

a is tuna
l is (tuna salad is good)
(rember-eq? a l) is (salad is good)

we don't need to give a name to (rember-f test?)

we can write ((rember-f test?) a l)

a is tuna
l is (shrimp salad and tuna salad)
((rember-f eq?) a l) is (shrimp salad and salad)

a is eq?
l is (equal? eq? eqan? eqlist? eqpair?)
((rember-f eq?) a l) is (equal? eqan? eqlist? eqpair?)

(define insertL
  (lambda (new old l)
    (cond
      ((null? l) (quote ()))
      ((eq? (car l) old) (cons new l))
      (else (cons (car l)
              (insertL new old (cdr l)))))))))

(define insertL-f
  (lambda (test?)
  	(lambda (new old l)
	    (cond
	      ((null? l) (quote ()))
	      ((test? (car l) old) (cons new l))
	      (else (cons (car l)
	              ((insertL-f test?) new old (cdr l))))))))

(define insertR
 (lambda (new old l)
   (cond
     ((null? l) (quote()))
     ((eq? old (car l)) 
       (cons old (cons new (cdr l))))
     (else (cons (car l) 
             (insertR new old (cdr l)))))))))

(define insertR-f
	(lambda (test?)
	 (lambda (new old l)
	   (cond
	     ((null? l) (quote()))
	     ((test? old (car l)) 
	     	 (cons old (cons new (cdr l))))
	     (else (cons (car l) 
	             ((insertR-f test?) new old (cdr l))))))))

(define seqL
	(lambda (new old l)
		(cons new l)))

(define seqR
	(lambda (new old l)
		(cons old (cons new l))))


(define inser-g
	(lambda (seq)
		(lambda (new old l)
			(cond
			  ((null? l) (quote()))
			  ((eq? (car l) old) (seq new old l))
			  (else (cons (car l) 
			          ((insert-g seq) new old (cdr l)))))))))

(define inserL (insert-g seqL))

(define insertR (inser-g seqR))

(define inserL
	(inser-g
		(lambda (new old l)
		(cons new l))))

(define inserR
	(inser-g
		(lambda (new old l)
		(cons old (cons new l)))))

; The Ninth Commandment
; Abstract common patterns with a new function

nexp is (+ (× 3 6) (↑ 8 2))
(value nexp) is (+ 18 64) is 82

(define value
	(lambda (nexp)
		(cond
			((atom? nexp) nexp)
			((eq? (car nexp) (quote +))
				(+ (value (car (cdr nexp))) 
					(value (car (cdr (cdr nexp))))))
			((eq? (car nexp) (quote ×))
				(× (value (car (cdr nexp))) 
					(value (car (cdr (cdr nexp))))))
			(else
				(↑ (value (car (cdr nexp))) 
					(value (car (cdr (cdr nexp)))))))))

(define 1st-sub-exp
	(lambda (aexp)
		(car (cdr aexp))))

(define 2nd-sub-exp
	(lambda (aexp)
		(car (cdr (cdr aexp)))))

(define operator
	(lambda (aexp)
		(car aexp)))

value with help functions
(define value
	(lambda (nexp)
		(cond
			((atom? nexp) nexp)
			((eq? (operator nexp) (quote +))
				(+ (value (1st-sub-exp nexp))
					(value (2nd-sub-exp nexp))))
			((eq? (operator nexp) (quote ×))
				(× (value (1st-sub-exp nexp)) 
					(value (2nd-sub-exp nexp))))
			(else
				(↑ (value (1st-sub-exp nexp)) 
					(value (2nd-sub-exp nexp)))))))

the 3 answers are same except for the +, ×, ↑

(define atom-to-function
	(lambda (x)
		(cond
			((eq? x (quote +)) +)
			((eq? x (quote ×)) ×)
			(else ↑))))

atom-to-function is a function
takes one argument x, x is an atom
return the function +, if (eq? x (quote +))
return the function ×, if (eq? x (quote ×))
return the function ↑, otherwise

nexp is (+ 5 3)
(atom-to-function (operator nexp)) is the function +
not the atom +

rewrite value
(define value
	(lambda (nexp)
		(cond
			((atom? nexp) nexp)
			(else
				((atom-to-function (operator nexp)) 
					(value (1st-sub-exp nexp))
					(value (2nd-sub-exp nexp)))))))

time for an apple
one a day kees the doctor away

a is cup
lat is (coffee cup tea cup and hick cup)
(multirember a lat) is (coffee tea and hick)

(define multirember
  (lambda (a lat)
    (cond
     ((null? lat) (quote ()))
     ((eq? (car lat) a)
      (multirember a (cdr lat)))
     (else (cons (car lat)
            (multirember a (cdr lat)))))))

write multirember-f
(define multirember-f
	(lambda test?
	  (lambda (a lat)
	    (cond
	     ((null? lat) (quote ()))
	     ((test? (car lat) a)
	      ((multirember-f test?) a (cdr lat)))
	     (else (cons (car lat)
	            ((multirember-f test?) a (cdr lat)))))))

a is tuna
test? is eq?
lat is (shrimp salad tuna salad and tuna)
((multirember-f eq?) a lat) is (shrimp salad salad and)

define multirember-eq? using multirember-f
(define multirember-eq?
	(multirember-f test?))

when multirember-f looks for tuna in lat
test? always stands for eq?
a always stands for tuna

we can combine a and test?
test? can be a function
it takes one argument
compare the argument to tuna

onw way to write this function
(define eq?-tuna
	(eq?-c k))

a different way
(define eq?-tuna
	(eq?-c (quote tuna)))

write multiremberT
multirember-f takes test? and returns a function
multiremberT takes a function like eq?-tuna and a lat

(define multiremberT
  (lambda (test? lat)
    (cond
     ((null? lat) (quote ()))
     ((test? (car lat))
      (multiremberT test? (cdr lat)))
     (else (cons (car lat)
            (multiremberT test? (cdr lat)))))))

test? is eq?-tuna
lat is (shrimp salad tuna salad and tuna)
(multiremberT test? lat) is (shrimp salad salad and)

(define multirember&co
	(lambda (a lat col)
		(cond
			((null? lat) (col (quote ()) (quote ())))
			((eq? (car lat) a) 
				(multirember&co a (cdr lat)
					(lambda (newlat seen)
						(col newlat (cons (car lat) seen)))))
			(else
				(multirember&co a (cdr lat)
					(lambda (newlat seen)
						(col (cons (car lat) newlat) seen)))))))

write a-friend
it takes 2 arguments
it asks whether the second one is the empty list
it ignore its first argument
(define a-friend
	(lambda (x y)
		(null? y)))

a is tuna
lat is (strawberries tuna and swordfish)
col is a-friend
(multirember&co a lat col) is ... not simple

a is tuna
lat is ()
col is a-friend
(multirember&co a lat col) is #t
a-friend uses in the first answer
a-friend makes sure that its second argument is empty

a is tuna
lat is (tuna)
col is a-friend
(multirember&co a lat col) is ?

multirember&co asks (eq? (car lat) (quote tuna))
it recurs on ()

the natural recursion is 
(multirember&co a (cdr lat)
	(lambda (newlat seen)
		(col newlat (cons (car lat) seen))))

multirember&co takes 3 arguments
the first one is tuna
the second one is ()
the third one is a new function

the name of the third argument is col

col stands for "collector"
a collector is called a "continuation"

a new collector
(define new-friend
	(lambda (newlat seen)
		(col newlat (cons (car lat) seen))))

if (car lat) is tuna
col is a-friend
the new collector by a new way
(define new-friend
	(lambda (newlat seen)
		(col newlat (cons (quote tuna) seen))))

we can replace col with a-friend
(define new-friend
	(lambda (newlat seen)
		(a-friend newlat (cons (quote tuna) seen))))

a is tuna
lat is (and tuna)
(multirember&co a lat a-friend) is ?

multirember&co asks else
it recurs on 
(multirember&co a (cdr lat)
	(lambda (newlat seen)
		(col (cons (car lat) newlat) seen)))

(define latest-friend
	(lambda (newlat seen)
		(a-friend (cons (quote and) newlat) seen)))














