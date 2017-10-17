; Tanner Bornemann
; 15 Oct 2017
; Lab05 Scheme Procedures
; CS4003 Programming Languages

(define int-builder
(lambda (n)
(if (= n 1)
'()
(append (int-builder (- n 1))
(list n)))))
(define filter-out-mults
(lambda (num lst)
    (if (null? lst)
        '()
        (if (= (modulo (car lst) num) 0)
            (filter-out-mults num (cdr lst))
            (cons (car lst) (filter-out-mults num (cdr lst)))))))
(define sieve
(lambda (lst)
    (if (null? lst)
        '()
        (cons (car lst) (sieve (filter-out-mults (car lst) (cdr lst)))))))
(define primes (lambda (n) (sieve (int-builder n))))
(define stol
(lambda (m)
    (let ((lst (primes (* m 20))))
    (take m lst))))
(define take
(lambda (m lst)
    (if (= m 0)
        '()
        (cons (car lst) (take (- m 1) (cdr lst))))))