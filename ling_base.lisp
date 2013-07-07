(setf (gethash 'table *noun*) (defclass table() ( (available_space :accessor available_space))))
(setf (gethash 'Greetings *trash*)  (list "hi" "Good Day" "hello"))
(setf (gethash 'make *functions*) "")
(setf (gethash 'spoon *definitions*) "")

;(setf (gethash 'take *functions*) "")
(setf (gethash 'sugar *definitions*) "")
(setf (gethash 'coffee *definitions*) "")
(setf (gethash 'water *definitions*) "")
(setf (gethash 'cup *definitions*) "cup")
;(setf (gethash '1 *word_comb*) (list "sus" "skaz" "ukaz"))


(setf (gethash 'increase *verb*) (defun increase (x) (incf x)))
(setf (gethash 'decrease *verb*) (defun decrease (x) (decf x)))
(setf (gethash 'put *verb*) (defun put (smth smwr) (let ((smthl (make-instance smth))) (setf (slot-value smthl 'available_space) smwr))))
(setf (gethash 'take *verb*) (defun take (smth smwr) (let ((smthl (make-instance smth))) (setf (slot-value smthl 'available_space) nil))))

(setf (gethash 'move *verb*) (defun move (smth &optional smwr) (let ((dx 0) (dy 0) (dr 0))
 ; (setf dx (- (car smwr) (cadr smth)))
  ;  (setf dy (- (cdr smwr) (caddr smth)))
      (setf dr (abs (- (cadr smth) (cdr smwr))))
     (setf dx (car smwr)) (setf dy (cdr smwr))
    (loop for i from 0 upto dr  collect i do
         (if (< dx 0) (setf (cadr smth) (decrease (cadr smth))))
          (if (> dx 0) (setf (cadr smth) (increase (cadr smth))))
           (if (< dy 0) (setf (caddr smth) (decrease (caddr smth))))
            (if (> dy 0) (setf (caddr smth) (increase (caddr smth))))))))
#|
 
(setf (gethash 'forward *noun*) (increase (cadr *self*)))
(setf (gethash 'backward *noun*) (decrease (caddr *self*)))
(setf (gethash 'left *noun*) (decrease  (cadr *self*)))
(setf (gethash 'right *noun*) (increase (caddr *self*)))
|#

(setf (gethash 'forward_ *noun*) (cons 1 0))
(setf (gethash 'backward_ *noun*) (cons -1 0))
(setf (gethash 'left_ *noun*) (cons 0 -1))
(setf (gethash 'right_ *noun*) (cons 0 1))

(setf (gethash 'forward *noun*) (defvar forward (gethash 'forward_ *noun*)))
(setf (gethash 'backward *noun*) (defvar backward (gethash 'backward_ *noun*)))
(setf (gethash 'left *noun*) (defvar left (gethash 'left_ *noun*)))
(setf (gethash 'right *noun*) (defvar right (gethash 'right_ *noun*)))