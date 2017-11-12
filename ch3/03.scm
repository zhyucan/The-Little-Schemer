a is mint
lat is (lamb chops and mint jelly)
(rember a lat) is (lamb chops and jelly)

a is mint
lat is (lamb chops and mint flavored mint jelly)
(rember a lat) is (lamb chops and flavored mint jelly)

a is totast
lat is (bacon lettuce and tomato)
(rember a lat) is (bacon lettuce and tomato)

a is cup
lat is (coffee cup tea cup and hick cup)
(rember a lat) is (coffee tea cup and hick cup)

(rember a lat)
takes two arguments, an atom, a lat
makes a new lat
the first occurrence of the atom in the old lat removed

what steps to do this?

first we test (null? lat) -- The First Commandment

if (null? lat) is true?
return ()

if (null? lat) is false?
we ask whether a is equal to (car lat)

how do we ask questions?
By using --
(cond
  (____ ____)
  (____ ____))

if a is equal to (car lat)
(eq? (car lat) a) is true

if (eq? (car lat) a) is true
the value of (rember a lat) is (cdr lat)

if (eq? (car lat) a) is false
find out if a if somewhere in the rest of the lat
(rember a (cdr lat))

there isn't any other question we should ask

(define rember
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      (else (cond
              ((eq? (car lat) a) (cdr lat))
              (else (rember a (cdr lat))))))))

the first example
a is bacon
lat is (bacon lettuce and tomato)

the first question is (null? lat)
move to the line

the next question
else is true

the next question
(eq? (car lat) a) is true
the value is (lettuce and tomato)

another example
a is and
lat is (bacon lettuce and tomato)

the first question is (null? lat)
movet to the next line

the next question
else is true

the next question
(eq? (car lat) a) is false
move to next line

the meaning of (else (rember a (cdr lat)))
else ask if else is true
it always is
the rest of the line says to recur rember(a lat)
this time, a is and, lat is (lettuce and tomato)

(null? lat) is false
move to the next line

else is true

(eq? (car lat) a) is false
move to the next line

the meaning of (rember a (cdr lat))
recur rember(a lat), a is and, lat is (and tomato)

(null? lat) is false
move to the next line

else, of course

(eq? (car lat) a) is true
the result is (cdr lat) -- (tomato)

is's not correct
the result should be (bacon lettuce tomato)

we dropped and
we also lost all the atoms preceding and

use Cons the Magnificent
we can keep from losing the atoms

; The Second Commandment
; Use cons to build lists

the old rember
(define rember
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      (else (cond
              ((eq? (car lat) a) (cdr lat))
              (else (rember a (cdr lat))))))))

the new rember using cons
(define rember
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      (else (cond
              ((eq? (car lat) a) (cdr lat))
              (else (cons (car lat) (rember a (cdr lat)))))))))

a is and
lat is (bacon lettuce and tomato)

the first question
(null? lat)

the next question
else is true

(eq? (car lat) a) is false
move to the next line

the meaning of (cons (car lat) (rember a (cdr lat)))
cons bacon onto the value of (rember a (cdr lat))

lat -> cdr lat
(bacon lettuce and tomato) -> (lettuce and tomato)
recur (rember a lat)

(null? lat) is false
move to next line

else is true

the next question
(eq? (car lat) a) is false
move tot next line

the meaning of (cons (car lat) (rember a (cdr lat)))
cons lettuce onto the value of (rember a (cdr lat))

lat -> cdr lat
(lettuce and tomato) -> (and tomato)
recur (rember a lat)

(null? lat) is false
move to next line

else is true

the next question
(eq? (car lat) a) is true
the value of ((eq? (car lat) a) (cdr lat)) is (cdr lat) is (tomato)

a is and, lat is (and tomato)
the value of (rember a lat) is (tomato)

a is and, lat is (lettuce and tomato)
(cons (car lat) (rember a (cdr lat))) is (lettuce tomato)
the value of (rember a lat) is (lettuce tomato)

a is and, lat is (bacon lettuce and tomato)
(cons (car lat) (rember a (cdr lat))) is (bacon lettuce tomato)
the value of (rember a lat) is (bacon lettuce tomato)

the new simple rember 

(define rember
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) a) (cdr lat))
      (else (cons (car lat) (rember a (cdr lat)))))))

l is ((apple peach pumpkin)
      (plum pear cherry)
      (grape raisin pea)
      (bean carrot eggplant))
(firsts l) is (apple plum grape bean)

l is ((a b) (c d) (e f))
(firsts l) is (a c e)

l is ()
(firsts l) is ()

l is ((five plums)
      (four)
      (eleven green oranges))
(firsts l) is (five four eleven)

l is (((five plums) four)
      (eleven green oranges)
      ((no) more))
(firsts l) is ((five plums) eleven (no))

firsts takes one argument, a list
a null list, or contains only non-empty lists
makes another list composed of the first S-expression of each internal list

the function firsts
(define firsts
  (lambda (l)
    (cond
      ((null? l) (quote()))
      (else (cons (car (car l)) (firsts (cdr l)))))))

; The Third Commandment
; When building a list
; decribe the first typical element
; and then cons it onto the natural recursion

in the function firsts
(car (car l)) is typical
(firsts (cdr l)) is natural recursion

example
l is ((a b) (c d) (e f))

(null? l) is false
move to the next line

the meaning of (cons (car (car l)) (firsts (cdr l)))
save (car (car l)) -- a to cons onto (firsts (cdr l))
recur with (firsts l), l is (cdr l) -- ((c d) (e f))

(null? l) is false
move to the next line

the meaning of (cons (car (car l)) (firsts (cdr l)))
save (car (car l)) -- c
recur with (firsts l), l is (cdr l) -- ((e f))

(null? l) is false
move to the next line

the meaning of (cons (car (car l)) (firsts (cdr l)))
save (car (car l)) -- e
recur with (firsts l), l is (cdr l) -- ()

(null? l) is true

new is topping
old is fudge
lat is (ice cream with fudge for dessert)
(insertR new old lat) is (ice cream with fudge topping for dessert)

new is jalapeno
old is and
lat is (tacos tamales and salsa)
(insertR new old lat) is (tacos tamales and jalapeno salsa)

new is e
old is d
lat is (a b c d f g d h)
(insertR new old lat) is (a b c d e f g d h)

insertR takes 3 arguments
new, old and lat
build a lat with new inserted to the right of the first occurrence of old

the function insertR
(define insertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote()))
      (else
        (cond
          ((eq? (car lat) old) (cons old (cons new (cdr lat))))
          (else (cons (car lat) (insertR new old (cdr lat)))))))))

the function insertL
(define insertL
  (lambda (new old lat)
    (cond
      ((null? lat) (quote()))
      (else
        (cond
          ((eq? (car lat) old) (cons new lat))
          (else (cons (car lat) (insertL new old (cdr lat)))))))))

new is topping
old is fudge
lat is (ice cream with fudge for dessert)
(subst new old lat) is (ice cream with topping for dessert)

the function subst
(define subst
  (lambda (new old lat)
    (cond
      ((null? lat) (quote()))
      (else
        (cond
          ((eq? (car lat) old) (cons new (cdr lat)))
          (else (cons (car lat) (subst new old (cdr lat)))))))))

new is vanilla
o1 is chocolate
o2 is banana
lat is (banana ice cream with chocolate topping)
(subst2 new o1 o2 lat) is (vanilla ice cream with chocolate topping)

the function subst2
(define subst2
  (lambda (new o1 o2 lat)
    (cond
      ((null? lat) (quote()))
      (else
        (cond
          ((or (eq? (car lat) o1) (eq? (car lat) o2))
            (cons new (cdr lat)))
          (else (cons (car lat) (subst2 new o1 o2 (cdr lat)))))))))

a is cup
lat is (coffee cup tea cup and hick cup)
(multirember a lat) is (coffee tea and hick)
(define multirember
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      (else 
        (cond
          ((eq? (car lat) a) (multirember a (cdr lat)))
          (else (cons (car lat) (multirember a (cdr lat)))))))))

(null? lat) is false
move to the next line

else is true

(eq? (car lat) a) is false
move to the next line

the meaning of (cons (car lat) (multirember a (cdr lat)))
save (car lat) -- coffee onto the value of (multirember a lat)

lat -> cdr lat
(coffee cup tea cup and hick cup) -> (cup tea cup and hick cup)

(null? lat) is false
move to the next line

else is true

(eq? (car lat) a) is true
recur with (multirember a lat), lat -- (tea cup and hick cup)

(null? lat) is false
move to the next line

else is true

(eq? (car lat) a) is false
move to the next line

the meaning of (cons (car lat) (multirember a (cdr lat)))
save (car lat) -- tea onto the value of (multirember a lat)

lat -> cdr lat
(tea cup and hick cup) -> (cup and hick cup)

(null? lat) is false
move to the next line

else is true

(eq? (car lat) a) is true
recur with (multirember a lat), lat -- (and hick cup)

(null? lat) is false
move to the next line

else is true

(eq? (car lat) a) is false
move to the next line

the meaning of (cons (car lat) (multirember a (cdr lat)))
save (car lat) -- and onto the value of (multirember a lat)

lat -> cdr lat
(and hick cup) -> (hick cup)

(null? lat) is false
move to the next line

else is true

(eq? (car lat) a) is false
move to the next line

the meaning of (cons (car lat) (multirember a (cdr lat)))
save (car lat) -- hick onto the value of (multirember a lat)

lat -> cdr lat
(hick cup) -> (cup)

(null? lat) is false
move to the next line

else is true

(eq? (car lat) a) is true
recur with (multirember a lat), lat -- ()

(null? lat) is true
so the value is ()

(define multiinsertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote()))
      (else
        (cond
          ((eq? (car lat) old) (cons (car lat) (cons new (multiinsertR new old (cdr lat)))))
          (else (cons (car lat) (multiinsertR new old (cdr lat)))))))))

; The Fourth Commandment
; Always change at least one argument while recuring.
; It must be changed to termination.
; The changing argument must be tested in the termination condition:
; when using cdr, test termination with null?.