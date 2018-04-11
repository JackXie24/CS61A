(define (find s predicate)
  (cond 
		((null? s) #f)
		((predicate (car s)) (car s))
		(else (find (cdr-stream s) predicate)))
)

(define (scale-stream s k)
  (cons-stream (* (car s) k) (scale-stream (cdr-stream s) k))
)

(define (has-cycle s)
  (define (tracker s t)
		(cond
			((null? t) #f)
			((eq? s t) #t)
			(else (tracker s (cdr-stream t)))))
	(tracker s (cdr-stream s))
)
(define (has-cycle-constant s)
  