; Tanner Bornemann
; 15 Oct 2017
; Lab06 Power of Lambda
; CS4003 Programming Languages

(define int-builder
  (lambda (n)
    (cons n (lambda () (int-builder (+ n 1))))))
(define sieve
  (lambda (s)
    (cons (car s)
          (lambda () (sieve (filter-out-mults (car s) ((cdr s))))))))
(define filter-out-mults
(lambda (num s)
    (if (null? s)
        '()
        (if (= (modulo (car s) num) 0)
            (filter-out-mults num ((cdr s)))
            (cons (car s) (lambda () (filter-out-mults num ((cdr s)))))))))
(define stol
  (lambda (n)
    (take n (sieve (int-builder 2)))))
    (define take
        (lambda (m s)
            (if (or (= m 0) (null? s))
                '()
                (cons (car s) (take (- m 1) ((cdr s)))))))