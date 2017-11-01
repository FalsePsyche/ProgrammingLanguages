;;; Class Answer Key
;;; 01 Nov 2017

(define call/cc call-with-current-continuation)

(define produce '())  ;;;  Round robin list of continuations
(define consume '())  ;;;  Consumer continuation

;;;  Here are the procedures to support co-routines in round-robin
(define remove-from-round-robin
  (lambda ()
    (set! produce (cdr produce))
    (if (null? produce) (consume 'done) ((car produce) '()))))

(define add-to-round-robin
  (lambda ()
    (call/cc 
     (lambda (k) (set! produce (append produce (list k))) (consume '())))))

(define step-and-swap
  (lambda (value)
    (call/cc 
     (lambda (k)
       (set! produce (append (cdr produce) (list k))) (consume value)))))

(define create
  (lambda (f a)
    (call/cc (lambda (k) (set! consume k) (add-to-round-robin) (f a)))))

(define demand
  (lambda ()
    (call/cc 
     (lambda (k)(set! consume k) (if (null? produce) '() ((car produce) '()))))))

(define demand-tokens
  (lambda ()
    (let ((temp (demand)))
      (if (null? temp) '() (cons temp (demand-tokens))))))

(define main 
  (lambda lst
    (map (lambda (x) (create pl x)) lst) (demand-tokens)))

;;;  Here is the pl function
(define pl
  (lambda (l)
    (if (null? l)
        (remove-from-round-robin)
        (begin (step-and-swap (car l)) (pl (cdr l))))))