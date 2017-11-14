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

(define value
	(lambda (nexp)
		(cond
			((atom? nexp) nexp)
			((eq? (operator nexp) (quote +))
				(加 (value (1st-sub-exp nexp))
					(value (2nd-sub-exp nexp))))
			((eq? (operator nexp) (quote ×))
				(× (value (1st-sub-exp nexp)) 
					(value (2nd-sub-exp nexp))))
			(else
				(↑ (value (1st-sub-exp nexp)) 
					(value (2nd-sub-exp nexp)))))))

(define atom-to-function
	(lambda (x)
		(cond
			((eq? x (quote 加)) +)
			((eq? x (quote ×)) ×)
			(else ↑))))

(define multirember
  (lambda (a lat)
    (cond
     ((null? lat) (quote ()))
     ((eq? (car lat) a)
      (multirember a (cdr lat)))
     (else (cons (car lat)
            (multirember a (cdr lat)))))))

(define multirember-f
	(lambda test?
	  (lambda (a lat)
	    (cond
	     ((null? lat) (quote ()))
	     ((test? (car lat) a)
	       ((multirember-f test?) a (cdr lat)))
	     (else (cons (car lat)
	             ((multirember-f test?) a (cdr lat))))))))

test? is eq?
a is tuna
lat is (shrimp salad tuna salad and tuna)
((multirember-f test?) a lat) is (shrimp salad salad and)

define multirember-eq? using multirember-f
(define multirember-eq?
	(multirember-f test?))