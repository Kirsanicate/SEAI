(defvar self nil)
(defvar s_mood (random 10)) ; s is for self, self mood, initially is a random number from 0 to 10, where 0 is awful.



(setf self nil)
(setf self (list "Self" 0 0))

#|---- Deprecated ---- |#
(defparameter *definitions* (make-hash-table))
(defparameter *functions* (make-hash-table))
(defparameter *commands* (make-hash-table))
(defparameter *pointers* (make-hash-table))
(defparameter *trash*(make-hash-table))
(defparameter *word_comb*(make-hash-table))
(defparameter *cur-room* (make-array 5 :fill-pointer 0 :adjustable t))
(defparameter *cr-room* (make-hash-table))
(defparameter *answ* (make-hash-table))

(defparameter *classes* (make-hash-table))
#|---- End of Deprecated ---- |#


(defparameter *noun* (make-hash-table))
(defparameter *verb* (make-hash-table))
(defparameter *opr* (make-hash-table))
(defparameter *patterns* (make-hash-table))
(setf (gethash '0 *patterns*) "0")
(defparameter *questions* (make-hash-table)) ; hash-table for everything, that have a question.

(defparameter *mood_modifiers* (make-hash-table)) ;There is only one table for mood modifiers, because we estimate everything from our point of view




(defvar test_x nil)

(load "~/ling_base.lisp")


(defun mood_analyzer()
  ())

(defun mood_modify(value) 
 (if (<=  ( + s_mood value) 10) (setf s_mood (+ s_mood value))))


  
(defmacro str_repl(name)
 ())

(defun class_creator(class_name)
   (setf (gethash class_name *classes*)
    (defclass class_name()
 ( 
 (cslot1 :accessor cslot1 :initform nil)
(cslot2 :accessor cslot2 :initform nil)))))


#|Input Parsing |#

#|
Not working
(defun command_parser_ex(string)
(declare (optimize (speed 3) (space 3) (safety 0) (debug 0)))
  (let ((space (position #\space string)))
    (if space
	 (cons (subseq string 0 space)
	      (command_parser_ex (subseq string (1+ space))))
	(list string))))
|#


(defun command_parser(str)
  (declare (optimize (speed 3) (space 3) (safety 0) (debug 0)))
   (let ((str_leng 0)
       (wh_spc nil)
       (word_list nil))
  (loop for i from 0 upto (- (length str) 1) collect i do
   (if (EQUAL (aref str i) #\Space)
       (push-end i wh_spc)))
     (loop for i from 0 upto (- (length wh_spc) 1) collect i
     do
     (if (= i 0)
       (if (not (EQUAL (subseq str 0 (elt wh_spc i)) ""))
      (push-end (subseq str 0 (elt wh_spc i)) word_list)))
      (if (> i 0)
       (if (not (EQUAL (subseq str (+ (elt wh_spc (- i 1)) 1) (elt wh_spc i)) ""))
        (push-end (subseq str (+ (elt wh_spc (- i 1)) 1) (elt wh_spc i)) word_list)))
       (if (= i (- (length wh_spc) 1))
          (if (not (EQUAL (subseq str (+ (elt wh_spc i) 1) (length str)) ""))
            (push-end (subseq str (+ (elt wh_spc i) 1) (length str)) word_list)))) 
 (loop for i from 0 upto (- (length  word_list) 1) collect i
 do
 (command_search (elt word_list i)))))

;  (print  wh_spc)
 ; (print (length wh_spc))
  ;  (setf str_leng (length str))
   ; (print str_leng)
  ;(print word_list)))
       

#| In future use defmethod with :before and :after methods. This will decrease size of source code and also may optimize search engine. |#

(defun def_search(str)
 (let ((com 0))
  (loop for str_srch being the hash-keys in *definitions* using (hash-value str_def)
   do 
   (if (EQUAL str str_def)
     (progn
      (print "Match found") (setf com 1))))
      (if (= com 0)
          (ask_for_unk_command))))

(defun command_search(str)
  #|TODO: ������� ����� ���� � ����, ���� ������� ������, ������ �� ��� ������ ��������� ���������, �� � ����������� � ������� �������. �� ����, �����������, ���� ������ �������, �������� ������.
���� ��, ������ ������ ������, ����� - ���������� ����������� -�������� �� �������, � ������� - ��� ������, ����, � ���
          |#
(let ((cycle 0)
      (result_pattern nil))
    (if (= cycle 0)
      (loop for def_srch being the hash-keys in *definitions* using (hash-value def_def)
      do 
      (if (EQUAL str def_def)
        (progn (def_search str)(setf cycle -1) (push def_def result_pattern)
        ))
       (if (not (EQUAl str def_def))
          (incf cycle))))
     (if (= cycle 1)
      (loop for verb_srch being the hash-keys in *verb* using (hash-value verb_def)
      do 
      (if (EQUAL str verb_def)
        (setf cycle -1))
       (if (not (EQUAl str verb_def))
          (incf cycle))))
          (if (= cycle 2)
      (loop for noun_srch being the hash-keys in *noun* using (hash-value noun_def)
      do 
      (if (EQUAL str noun_def)
        (setf cycle -1))
       (if (not (EQUAl str noun_def))
          (incf cycle))))
    (if (= cycle 3)
        (loop for point_srch being the hash-keys in *pointers*  using (hash-value point_def)
      do 
      (if (EQUAL str point_def)
        (setf cycle -1))
       (if (not (EQUAl str point_def))
          (incf cycle))))))

;(defun trash_search(str)
 ; (loop for tr_srch being the hash-keys in *trash* using (hash-value tr_def)
  ;  do
   ;   (if (EQUAL str tr_def)
    ;   (print "Match Found")))) 


(defun message_type(str)
; (if (not (EQUAL (find #\? str  :test #'equal :from-end t) nil))
; (print "ss"))
  (if  (EQUAL #\? (aref str (- (length str) 1)))
    (print "It is question!"))
    (if (EQUAL #\. (aref str (- (length str) 1)))
      (print "It is statement!"))
)

(defun pattern_creator(str)
  (let ((p_id 0))
  (loop for pattern being the hash-values in *patterns* using (hash-key pattern_id)
        do
          (setf p_id  (+ 1 pattern_id)))
          (setf (gethash p_id *patterns*) str) 
))



(defun pattern_search()
 (loop for pattern_srch being the hash-keys in *patterns* using (hash-value pattern_result)
   do
    (print "lol")
   )
)




#| Answer block |#

(defun user_answer(str))

#|Unknown commands section |#
(defun ask_for_unk_command()
 (print "Command Unknown, pl0x give m3 som3 definitions"))

(defun add_definition(str defin)
  (setf (gethash str *definitions*) defin))
