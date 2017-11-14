1 is arithmetic expression

3 is arithmetic expression

1 + 3 is arithmetic expression

1 + 3 × 4 is arithmetic expression

cookie is arithmetic expression

3 ↑ y + 5 is arithmetic expression

arithmetic expression is either an atom
or two arithmetic expressions combined by +, ×, or ↑

(quote a) is a

(quote +) is +
the atom +, not the operation 加

(quote ×) is ×
the atom ×, not the operation ×

y is a
(eq? (quote a) y) is True

y is a
x is a
(eq? x y) is True

(n + 3) is not arithmetic expression
definition  of arithmetic expression does not mention parentheses

but we can think of (n + 3) as an arithmetic expression

we call (n + 3) a representation for n + 3

x is 1
(numbered? x) is True

(3 + (4 × 5)) represent 3 + 4 × 5

y is (3 + (4 ↑ 5))
(numbered? y) is True

z is (2 × sausage)
(numbered? z) is false
sausage is not a number

numbered determine whether a representation of an arithmetic expression
contains only numbers besides the +, ×, ↑

the function numbered?
(define numbered?
	(lambda (aexp)
		(cond
			((atom? aexp) (number? aexp))
			(eq? (car (cdr aexp)) (quote +) 
				(and (numbered? (car aexp))
					(numbered? (car (cdr (cdr aexp))))))
			(eq? (car (cdr aexp)) (quote ×) 
				(and (numbered? (car aexp))
					(numbered? (car (cdr (cdr aexp))))))
			(eq? (car (cdr aexp)) (quote ↑) 
				(and (numbered? (car aexp))
					(numbered? (car (cdr (cdr aexp)))))))))

the simple numbered?
(define numbered?
	(lambda (aexp)
		(cond
			((atom? aexp) (number? aexp))
			(else
				(and (numbered? (car aexp))
					(numbered? (car (cdr (cdr aexp)))))))))

u is 13
(value u) is 13

x is (1 + 3)
(value x) is 4

y is (1 + (3 ↑ 4))
(value y) is 82

z is cookie
(value z) no answer

(value nexp) return natural value of a numbered arithmetic expression

value ask 4 questions about nexp

; The Seventh Commandment
; Recur on the subparts that are of the same nature:
; On the sublists of a list.
; On the subexpressions of an arithmetic expression

the function value
(define value
	(lambda (nexp)
		(cond
			((atom? nexp) nexp)
			((eq? (car (cdr nexp)) (quote +))
				(加 (value (car nexp)) 
					(value (car (cdr (cdr nexp))))))
			((eq? (car (cdr nexp)) (quote ×))
				(× (value (car nexp)) 
					(value (car (cdr (cdr nexp))))))
			(else
				(↑ (value (car nexp)) 
					(value (car (cdr (cdr nexp)))))))))

some different representation of arithmetic expressions
(3 4 +) represent 3 + 4
(+ 3 4) represent 3 + 4
(plus 3 4) represent 3 + 4

(+ (× 3 6) (↑ 8 2)) is arithmetic expression

the new function value
(define value
	(lambda (nexp)
		(cond
			((atom? nexp) nexp)
			((eq? (car nexp) (quote +))
				(加 (value (car (cdr nexp))) 
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

we can use help functions to hide the representation

now write value again
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

; The Eighth Commandment
; Use help functions to abstract from representations