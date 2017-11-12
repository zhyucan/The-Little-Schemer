(lat? (Jack Sprat could eat no chicken fat)) is True

(lat? ((Jack) Sprat could eat no chicken fat)) is False

(lat? (Jack (Sprat could) eat no chicken fat)) is False

(lat? ()) is True

a lat is a list of atoms

lat? = ?

(define lat?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((atoms? (car l)) (lat? (cdr l)))
      (else #f))))
l is (bacon and eggs)
(lat? (bacon and eggs)) is #t is True

(cond ...) asks questions
(lambda ...) creates a function
(define ...) gives it a name

this first question asked by (lat? l) is (null? l)

the meaning of ((null? l) #t)
if l is the null list, the value of the application is true
if l is not null list, we ask the next question

the next question is (atom? (car l))

the meaning of ((atom? (car l)) (lat? (cdr l)))
if (car l) is atom, if (cdr l) is composed of atoms?
if (car l) is not atom, we ask the next question

(car l) is atom, the value of the function is the value of (lat? (cdr l))

the meaning of (lat? (cdr l))
lat? have a new argument
(lat? (cdr l)) finds out if the rest of l is composed only of atoms

l -> cdr l
(lat? (bacon and eggs)) -> (lat? (and eggs))

the next question is (null? l)

the meaning of ((null? l) #t)
if l is the null list, the value of the application is #t
if l is not null list, we ask the next question

the next question is (atom? (car l))

the meaning of ((atom? (car l)) (lat? (cdr l)))
if (car l) is atom, if (cdr l) is composed of atoms?
if (car l) is not atom, we ask the next question

(car l) is atom, the value of the function is the value of (lat? (cdr l))

the meaning of (lat? (cdr l))
lat? have a new argument
(lat? (cdr l)) finds out if the rest of l is composed only of atoms

l -> cdr l
(lat? (and eggs)) -> (lat? (eggs))

the next question is (null? l)

the meaning of ((null? l) #t)
if l is the null list, the value of the application is #t
if l is not null list, we ask the next question

the next question is (atom? (car l))

the meaning of ((atom? (car l)) (lat? (cdr l)))
if (car l) is atom, if (cdr l) is composed of atoms?
if (car l) is not atom, we ask the next question

(car l) is atom, the value of the function is the value of (lat? (cdr l))

the meaning of (lat? (cdr l))
lat? have a new argument
(lat? (cdr l)) finds out if the rest of l is composed only of atoms

l -> cdr l
(lat? (eggs)) -> (lat? ())

the next question is (null? l)

the meaning of ((null? l) #t)
if l is the null list, the value of the application is #t
if l is not null list, we ask the next question

() is the null list
the value of the application (lat? (bacon and eggs)) is #t -- true

describe what the function lat?
lat? looks at each S-expression in a list, in turn,
and asks if each S-expression is an atom, 
until it runs out of S-expression.
If it runs out without encountering a list, the value is #t
If it finds a list, the value is #f -- false.

l is (bacon (and eggs))
(lat? l) is #f

the next question is (null? l)

the meaning of ((null? l) #t)
if l is the null list, the value of the application is #t
if l is not null list, we ask the next question

the next question is (atom? (car l))

the meaning of ((atom? (car l)) (lat? (cdr l)))
if (car l) is atom, if (cdr l) is composed of atoms?
if (car l) is not atom, we ask the next question

(car l) is atom, the value of the function is the value of (lat? (cdr l))

the meaning of (lat? (cdr l))
lat? have a new argument
(lat? (cdr l)) finds out if the rest of l is composed only of atoms

l -> cdr l
(lat? (bacon (and eggs))) -> (lat? (and eggs))

the next question is (null? l)

the meaning of ((null? l) #t)
if l is the null list, the value of the application is #t
if l is not null list, we ask the next question

the next question is (atom? (car l))

the meaning of ((atom? (car l)) (lat? (cdr l)))
if (car l) is atom, if (cdr l) is composed of atoms?
if (car l) is not atom, we ask the next question

the next question is else

else asks if else is true

else is always true

if else is true, the answer is #f -- false

l1 is ()
l2 is (d e f g)
(or (null? l1) (atom? l2)) is True

l1 is (a b c)
l2 is ()
(or (null? l1) (null? l2)) is True

l1 is (a b c)
l2 is (atom)
(or (null? l1) (null? l2)) is False

(or ...) asks two questions, one at a time
If the first one is true, the answer is true
If the first one is false, the answer is the second question answers

a is tea
lat is (coffee tea or milk)
a is a member of lat

a is poached
lat is (fried eggs and scrambled eggs)
(member? a lat) is False

this is the function member?
(define member?
	(lambda (a lat)
		(cond
			((null? lat) #f)
			(else (or (eq? (car lat) a)
							(member? a (cdr lat)))))))

a is meat
lat is (mashed potatoes and meat gray)
the value of (member? a lat) is #t

the first question asked by (member? a lat) is (null? lat)
(null? lat) is also the first question asked by lat?

; The first Commandment
; (preliminary)
; Always ask null? as the first question in epressing any function

the meaning of ((null? lat) #f)
if lat is the null list, the value is #f
if not, we ask the next question

the next question is else

else is a question whose value is always true

the meaning of (else (or (eq? (car lat) a) (member? a (cdr lat))))
(car lat) = a, the answer is true
(car lat) != a, the answer is the value of (member? a (cdr lat))

(car lat) is mashed
a is meat
(car lat) != a

the second question of (or ...) is (member? a (cdr lat))

lat -> cdr lat
(mashed potatoes and meat gray) -> (potatoes and meat gray)
(member? a lat) -> (member a (cdr lat))

the next question is (null? lat)

(null? lat) is #f -- false

the next question is else

the value of (else (or (eq? (car lat) a) (member? a (cdr lat))))
((car lat) a) is false
we ask (member? a (cdr lat))

lat -> cdr lat
(potatoes and meat gray) -> (and meat gray)
(member? a lat) -> (member? a (cdr lat))

the next question is (null? lat)

(null? lat) is #f -- false

the next question is else

the value of (else (or (eq? (car lat) a) (member? a (cdr lat))))
((car lat) a) is false
we ask (member? a (cdr lat))

lat -> cdr lat
(and meat gray) -> (meat gray)
(member? a lat) -> (member? a (cdr lat))

the next question is (null? lat)

(null? lat) is #f -- false

the next question is else

the value of (else (or (eq? (car lat) a) (member? a (cdr lat))))
((car lat) a) is #t -- true

lat is (meat gravy)
the value of the application (member? a lat) is #t

lat is (and meat gravy)
the value of the application (member? a lat) is #t

lat is (potatoes and meat gravy)
the value of the application (member? a lat) is #t

lat is (mashed potatoes and meat gravy)
the value of the application (member? a lat) is #t

the value of (member? a lat)
a is liver
lat is (bagels and lox)

(null? lat) is #f
move to the next line

else is #t
(eq? (car lat) a) is #f
recur with (member? a lat), a is liver, lat is (and lox)

(null? lat) is #f
move to the next line

ele is #t
(eq? (car lat) a) is #f
recur with (member? a lat), a is liver, lat is (lox)

(null? lat) is #f
move to the next line

else is #t
(eq? (car lat) a) is #f
recur with (member? a lat), a is liver, lat is ()

(null? lat) is #t

a is liver, lat is ()
(member? a lat) is #f

a is liver, lat is (lox)
(or (eq? (car lat) a) (member? a (cdr lat))) is #f

a is liver, lat is (lox)
(member? a lat) is #f

a is liver, lat is (and lox)
(or (eq? (car lat) a) (member? a (cdr lat))) is #f

a is liver, lat is (and lox)
(member? a lat) is #f

a is liver, lat is (bagels and lox)
(or (eq? (car lat) a) (member? a (cdr lat))) is #f

a is liver, lat is (bagels and lox)
(member? a lat) is #f
