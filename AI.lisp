(defvar self nil)
(defvar s_mood (random 10)) ; s is for self, self mood, initially is a random number from 0 to 10, where 0 is awful.
(defvar s_laziness 0)
(defvar s_fatigue 0)


(setf self nil)
(setf self (list "Self" 0 0))

(defparameter *list_of_hashes* (make-hash-table))

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

(defparameter *word_mood_rating* (make-hash-table))
(defparameter *word_usage_rating* (make-hash-table))

(defparameter *word_rating* (make-hash-table))

(defparameter *word_combinations* (make-hash-table))


(defparameter *unspecified* (make-hash-table))



(setf (gethash '0 *patterns*) "0")


(defparameter *questions* (make-hash-table)) ; hash-table for everything, that have a question.

(defparameter *mood_modifiers* (make-hash-table)) ;There is only one table for mood modifiers, because we estimate everything from our point of view




(defvar test_x nil)

(load "~/ling_base.lisp")
(load "~/instance_functions.lisp")
(load "~/creative_functions.lisp")

(defun attributes_analyzer()
  (let ((start_mood s_mood)
        (start_fatigue s_fatigue)
        (start_laziness s_laziness)
        (mood_mod 3)
        (fatigue_mod 3)
        (lazy_mod 3)
        (cur_mood s_mood)
        (cur_fatigue s_fatigue)
        (cur_laziness s_laziness)) 
     (if (integerp (/ start_mood mood_mod))
      
        (progn
          
       ))
  )
)


(defun mood_analyzer()
  ())

(defun mood_modify(value) 
 (if (<=  ( + s_mood value) 10) (setf s_mood (+ s_mood value))))



  
(defmacro str_repl(name)
 ())



;  (setf (gethash class_name *classes*)
  ;  (defclass class_name()
 ;( 
 ;(cslot1 :accessor cslot1 :initform nil)
;(cslot2 :accessor cslot2 :initform nil)))))


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


(defun text_parser(str)
  (declare (optimize (speed 3) (space 3) (safety 1) (debug 0)))
   (let ((res_string))     
    (setf res_string (subseq str 0 (position #\. str)))))
         


(defun command_parser(str &optional key)
  (declare (optimize (speed 3) (space 3) (safety 0) (debug 0)))
   (let ((str_leng 0)
       (wh_spc nil)
       (word_list nil))
  (loop for i from 0 upto (- (length str) 1) collect i do
   (if (EQUAL (aref str i) #\Space)
       (push-end i wh_spc)))
   (if (not (= (length wh_spc) 0))
     (loop for i from 0 upto (- (length wh_spc) 1) collect i
     do
     (if (= i 0)
      (push-end  str word_list))
      (if (> i 0)
       (if (not (EQUAL (subseq str (+ (elt wh_spc (- i 1)) 1) (elt wh_spc i)) ""))
        (push-end (subseq str (+ (elt wh_spc (- i 1)) 1) (elt wh_spc i)) word_list)))
       (if (= i (- (length wh_spc) 1))
          (if (not (EQUAL (subseq str (+ (elt wh_spc i) 1) (length str)) ""))
            (push-end (subseq str (+ (elt wh_spc i) 1) (length str)) word_list)))))
     (if (= (length wh_spc) 0)
       (push str word_list))
 (loop for i from 0 upto (- (length  word_list) 1) collect i
do
 (command_search (elt word_list i))
 (print i)
 ))) 

;  (print  wh_spc)
 ;(print (length wh_spc))
  ;  (setf str_leng (length str))
   ; (print str_leng)
 ; (print word_list)))
       

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

  #|TODO: сделать поиск слов в базе, если находим глагол, значит за ним должны следовать указатели, их и подставляем в функцию глагола. То есть, анализируем, ищем схожие глаголы, забиваем данные.
Либо же, делаем анализ текста, потом - составляем предложение -указание по шаблону, к примеру - что делать, кому, с чем
1 - for definition (addition)
2 - for verb
3 - for noun
4 - for objective (pointers)

So in result we will have some patterns for search.
For example, proper sentences in English builds in this way

Noun + Verb + Additive(adjective/addition?) + Objective

So result pattern will be like ("3", "2", "1", "4")

 or

Objective + Noun + Verb + Addjective?

Result pattern is ("4", "3", "2", "1")
 
 
|#
(let ((cycle 0)
      (result_pattern nil))
    (if (= cycle 0)
      (loop for def_srch being the hash-keys in *definitions* using (hash-value def_def)
      do 
      (if (EQUAL str def_def)
        (progn (def_search str)(setf cycle -1) (push 1 result_pattern)
        ))
       (if (not (EQUAl str def_def))
          (incf cycle))))
     (if (= cycle 1)
      (loop for verb_srch being the hash-keys in *verb* using (hash-value verb_def)
      do 
      (if (EQUAL str verb_def)
        (progn (setf cycle -1) (push-end 2 result_pattern )))
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
          (incf cycle))))
     (if (= cycle 5) ; "Magic 5" - trace why cycle is incremented twice
       (add_to_unspecified str))   
    ))


(defun add_to_unspecified(str)
 (setf (gethash str *unspecified*) str)
  )


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
      (print "It's a statement"))
)


(defun pattern_search()
 (loop for pattern_srch being the hash-keys in *patterns* using (hash-value pattern_result)
   do
    (print "lol")
   )
)


(defun message_analitics(str)
  (message_type str)
   (command_parser str))


#| Answer block |#

(defun user_answer(str))

#|Unknown commands section |#
(defun ask_for_unk_command()
 (print "Command Unknown, pl0x give m3 som3 definitions"))

(defun prompt_read(prompt)
  (format *query-io* "~a: " prompt)
  (force-output *query-io*)
  (read-line *query-io*))

(defun ask_about_unspecified()
  (loop for unknown being the hash-keys in *unspecified* using (hash-value unknown_word)
        do
        (let  ((cur_result nil))
        (setf cur_result  (prompt_read "Is this a noun?"))          
          (if (not (EQUAL (find "YES" (string-upcase cur_result)) NIL))
            (setf (gethash unknown_word *noun* ) unknown_word)
            (prompt_read "Is it a verb?"))
          
           (if (EQUAL (find "YES" (string-upcase cur_result)) NIL)
          (progn  (setf cur_result (prompt_read "Is this a verb?"))
               (print cur_result))

            )
          
            (if (EQUAL (find "YES" (string-upcase cur_result)) NIL)
              (setf cur_result (prompt_read "Is this an adj?")))
          )
        
        ))

(defun main()
  (do () (()) ))