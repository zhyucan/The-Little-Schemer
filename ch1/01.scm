atom 是一个 atom

turkey 是一个 atom

1492 是一个 atom

u 是一个 atom

*abc$ 是一个 atom

(atom) 是一个 list

(atom turkey or) 是一个 list

(atom turkey) or 不是一个 list

((atom turkey) or) 是一个 list

xyz 是一个 S-expression

(x y z) 是一个 S-expression

((x y) z) 是一个 S-expression

(how are you doing so far) 是一个 list

(how are you doing so far) 有六个 S-expressions

(((how) are) ((you) (doing so)) far) 是一个 list

(((how) are) ((you) (doing so)) far) 有三个 S-expressions

() 是一个 list

() 不是一个 atom

(() () () ()) 是一个 list

(a b c) 的 car 是 a

((a b c) x y z) 的 car 是 (a b c)

hotdog 没有 car

() 没有 car

;; The Law of Car
;; The primitive car is defined only for non-empty lists

(((hotdogs)) (and) (pickle) relish) 的 car 是 ((hotdogs))

(car (((hotdogs)) (and) (pickle) relish)) 是 ((hotdogs))

(car (car (((hotdogs)) (and) (pickle) relish))) 是 (hotdogs)

(a b c) 的 cdr 是 (b c)

((a b c) x y z) 的 cdr 是 (x y z)

(hamburger) 的 cdr 是 ()

(cdr ((x) t r)) 是 (t r)

(cdr hotdogs) 不存在

(cdr ()) 不存在

;; The Law of Cdr
;; The primitive cdr is defined only for non-empty list
;; The cdr of any non-empty list is always another list

(car (cdr ((b) (x y) ((c))))) 是 (x y)

(cdr (cdr ((b) (x y) ((c))))) 是 (((c)))

(cdr (car (a (b (c)) d))) 不存在

car 的参数可以是任何非空 list

cdr 的参数可以是任何非空 list

Peanut 和 (butter and jelly) 的 cons 是 (peanut butter and jelly)

(cons peanut (butter and jelly)) 的 cons 是 (peanut butter and jelly)

(banana and) 和 (peanut butter and jelly) 的 cons 是 ((banana and) peanut butter and jelly)

(cons ((help) this) (is very ((hard) to learn))) 是 (((help) this) is very ((hard) to learn))

cons 有两个参数，第一个是任何 S-expression，第二个是任何 list

(cons (a b (c)) ()) 是 ((a b (c)))

(cons ((a b c)) b) 不存在

(cons a b) 不存在

;; The Law of Cons
;; The primitive cons takes two arguments
;; The second argument to cons must be a list
;; The result is a list

(cons a (car ((b) c d))) 是 (a b)

(cons a (cdr ((b) c d))) 是 (a c d)

() 是 null list

(null? ()) 是 True

(null? (quote())) 是 True

(null? (a b c)) 是 False

(null? spaghetti) 不存在

;; The Law of Null?
;; The primitive null? is defined only for list.

Harry 是 atom? 是 True

(atom? Harry) 是 True

(atom? (Harry had a heap of apples)) 是 False

atom? 有一个参数，它可以是任何 S-expression

(atom? (car (Harry had a heap of apples))) 是 True

(atom? (cdr (Harry had a head of apples))) 是 False

(atom? (cdr (Harry))) 是 False

(atom? (car (cdr (swing low sweet cherry oat)))) 是 True

(atom? (car (cdr (swing (low sweet) cherry oat)))) 是 False

Harry 和 Harry 相同？ 是 True

(eq? Harry Harry) 是 True

(eq? margarine butter) 是 False

eq? 有两个参数，它们都是非数字的 atom

(eq? () (strawberry)) 不存在

(eq? 6 7) 不存在

;; The Law of Eq?
;; The primitive eq? takes two arguments
;; Each must be a non-numeric atom

(eq? (car (Mary had a little lamb chop)) Mary) 是 True

(eq? (cdr (soured milk)) milk) 不存在

(eq? (car (beans beans we need jelly beans)) (car (cdr (beans beans we need jelly beans)))) 是 True



-> Now go make yourself a peanut butter and jelly sandwich <-
