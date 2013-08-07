(defun new_hash(name)
  (setf (gethash name *list_of_hashes*) (make-hash-table)))


(defun class_creator(class_name)
  (setf (gethash class_name *classes*) `(defclass ,class_name() (cslot1 :accessor cslot1 :initform nil) (cslot2 :accessor cslot2 :initform nil))))
