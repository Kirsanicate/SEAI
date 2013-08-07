(defun pattern_creator(str)
  (let ((p_id 0))
  (loop for pattern being the hash-values in *patterns* using (hash-key pattern_id)
        do
          (setf p_id  (+ 1 pattern_id)))
          (setf (gethash p_id *patterns*) str) 
))



(defun add_definition(str defin)
  (setf (gethash str *definitions*) defin))
