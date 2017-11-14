(apple peaches apple plum) is not a set
apple appears more than once

lat is (apples peaches pears plums)
(set? lat) is #t
not atom appears more than once

lat is ()
(set? lat) is #t
not atom appears more than once

the function set?
(define set?
	(lambda (lat)
		(cond
			((null? lat) #t)
			((member? (car lat) (cdr lat)) #f)
			(else (set? (cdr lat))))))

lat is (apple peach pear peach plum apple lemon peach)
(makeset lat) is (apple peach pear plum lemon)

(define makeset
	(lambda (lat)
		(cond
			((null? lat) (quote ()))
			((member? (car lat) (cdr lat)) (makeset (cdr lat)))
			(else (cons (car lat) (makeset (cdr lat)))))))

set1 is (5 chicken wings)
set2 is (5 hamburgers 2 pieces fried chicken and light duckling wings)
(subset? set1 set2) is #t
each atom in set1 is also in set2

set1 is (4 pounds of horseradish)
set2 is (four pounds chicken and 5 ounces horseradish)
(subset? set1 set2) is #f

the function subset?
(define subset?
	(lambda (set1 set2)
		(cond
			((null? set1) #t)
			((member? (car set1) set2) (subset? (cdr set1) set2))
			(else #f))))))

write subset? with (and ...)
(define subset?
	(lambda (set1 set2)
		(cond
			((null? set1) #t)
			(else
				(and (member? (car set1) set2) 
					(subset? (cdr set1) set2))))))

set1 is (6 large chickens with wings)
set2 is (6 chickens with large wings)
(eqset? set1 set2) is #t

write eqset? with one cond-line
(define eqset?
	(lambda (set1 set2)
		(and (subset? set1 set2) (subset? set2 set1))))

set1 is (stewed tomatoes and macaroni)
set2 is (macaroni and cheese)
(intersect? set1 set2) is #t
at least one atom in set1 is in set2

the function intersect?

(define intersect?
	(lambda (set1 set2)
		(cond
			((null? set1) #f)
			((member? (car set1) set2) #t)
			(else (intersect? (cdr set1) set2)))))

write intersect? with (or ...)
(define intersect?
	(lambda (set1 set2)
		(cond
			((null? set1) #f)
			(else
				(or (member? (car set1) set2) 
					(intersect? (cdr set1) set2))))))

set1 is (stewed tomatoes and macaroni)
set2 is (macaroni and cheese)
(intersect set1 set2) is (and macaroni)

the function intersect
(define intersect
	(lambda (set1 set2)
		(cond
			((null? set1) (quote()))
			((member? (car set1) set2)
				(cons (car set1) (intersect? (cdr set1) set2)))
			(else (intersect (cdr set1) set2)))))

set1 is (stewed tomatoes and macaroni casserole)
set2 is (macaroni and cheese)
(union set1 set2) is (stewed tomatoes casserole macaroni and cheese)

write union
(define union
	(lambda (set1 set2)
		(cond
			((null? set1) set2)
			((member? (car set1) set2) (union (cdr set1) set2))
			(else (cons (car set1) (union (cdr set1) set2))))))

write xxx
(define xxx
	(lambda (set1 set2)
		(cond
			((null? set1) (quote()))
			((member? (car set1) set2) (xxx (cdr set1) set2))
			(else (cons (car set1) (xxx (cdr set1) set2))))))

l-set is ((a b c) (c a d e) (e f g h a b))
(intersectall l-set) is (a)

l-set is ((6 pears and)
					(3 peaches and 6 peppers)
					(8 pears and 6 plums)
					(and 6 prunes with some apples))
(intersectall l-set) is (6 and)

write intersectall
(define intersectall
	(lambda (l-set)
		(cond
			((null? (cdr l-set)) (car l-set))
			(else (intersect (car l-set) (intersectall (cdr l-set)))))))

(pear pear) is pair
it's a list with only 2 atoms

(3 7) is pair

((2) (pair)) is pair
it's a list with only 2 S-expressions

l is (full (house))
(a-pair? l) is #t

write a-pair?
(define a-pair?
	(lambda (x)
		(cond
			((atom? x) #f)
			((null? x) #f)
			((null? (cdr x)) #f)
			((null? (cdr (cdr x))) #t)
			(else #f))))

the first S-expression of a pair is the car of the pair

the second S-expression of a pair is the car of the cdr of the pair

build a pair with 2 atoms or S-expressions
(cons x1 (cons x2 (quote ())))

(define first
	(lambda (p)
		(car p)))

(define second
	(lambda (p)
		(car (cdr p))))

(define build
	(lambda (s1 s2)
		(cons s1 (cons s2 (quote ())))))

first and second get parts of pairs
build make pairs

write third
(define third
	(lambda (l)
		(car (cdr (cdr l)))))

l is (apples peaches pumpkin pie)
l is not rel
l is not a list of pairs
rel stand for relation

l is ((apples peaches) (pumpkin pie) (apples peaches))
l is not rel
l is not a set of pairs

l is ((apples peaches) (pumpkin pie))
l is rel

l is ((4 3) (4 2) (7 6) (6 2) (3 4))
l is rel

rel is ((4 3) (4 2) (7 6) (6 2) (3 4))
rel is not a fun
fun stand for function

rel is ((8 3) (4 2) (7 6) (6 2) (3 4))
(fun? rel) is #t
(firsts rel) -- (8 4 7 6 3) is a set

rel is ((d 4) (b 0) (b 9) (e 5) (g 4))
(func? rel) is #f
(firsts rel) -- (d b b e g) is not a set

(define firsts
  (lambda (l)
    (cond
      ((null? l) (quote()))
      (else (cons (car (car l)) (firsts (cdr l)))))))

write fun?
(define fun?
	(lambda (rel)
		(set? (firsts rel))))

a finite function is a list a pairs in which
no first element of any pair is the same as
any other first element

rel is ((8 a) (pumpkin pie) (got sick))
(revrel rel) is ((a 8) (pie pumpkin) (sick got))

write revrel
(define revrel
	(lambda (rel)
		(cond
			((null? rel) (quote ()))
			(else
				(cons (build (second (car rel)) (first (car rel)))
					(revrel (cdr rel)))))))

revrel without help functions
(define revrel
  (lambda (rel)
    (cond
      ((null? rel) (quote ()))
      (else (cons (cons (car (cdr (car rel)))
                        (cons (car (car rel))
                              (quote ())))
                  (revrel (cdr rel)))))))

(define revpair
	(lambda (pair)
		(build (second pair) (first pair))))

the new revrel
(define revrel
	(lambda (rel)
		(cond
			((null? rel) (quote ()))
			(else
				(cons (revpair (car rel)) (revrel (cdr rel)))))))

fun is ((8 3) (4 2) (7 6) (6 2) (3 4))
fun is not a fullfun
(3 2 6 2 4) is not a set

fun is ((8 3) (4 8) (7 6) (6 2) (3 4))
(fullfun? fun) is #t
(3 8 6 2 4) is a set

fun is ((grape raisin) (plum prune) (stewed prune))
(fullfun? fun) is #f

fun is ((grape raisin) (plum prune) (stewed grape))
(fullfun? fun) is #t
(raisin prune grape) is a set

write fullfun?
(define fullfun?
	(lambda (fun)
		(set? (seconds fun))))

the new fullfun?
(define fullfun?
	(lambda (fun)
		(fun? (revrel fun))))