(defun print-list (items)
 (when (not (first items)) (return-from print-list))
 (format t "~a" (first items))
 (let ((lsize (length items)))
	(cond
	 ((= lsize 2) (format t " and ~a" (second items)))
	 ((> lsize 2) 
		(loop for index from 1 to (- lsize 2)
		 do (format t ", ~a" (elt items index)))
		(format t ", and ~a" (elt items (1- lsize))))))
 (format t "~%"))

(defun lookable (source) 
  "tell whether the source object can be seen from the player's position
	For the time being, only things that are in the current location or are
	the current location will be lookable."
  (or (equalp (third (gethash "me" *objects*)) 
	     (third (gethash source *objects*)))
      (equal (third (gethash "me" *objects*))
	     source )))

(defun describe-thing ( descrip )
  "This just needs to show a description of the given object"
  (if (first descrip)
    (progn (format t "~a ~%" (first descrip)) 
	   (return-from describe-thing T))
    (loop for parent in (second descrip)
	  do (describe-thing parent))))

(defun list-contents ( descrip )
  "This will just print out the contents of the object"
	(when (first (fourth descrip))
	 (format t "You see here: ")
	 (print-list (fourth descrip))))

(defun do-look (sentence)
 (let ((target (space-concat (remove-common (rest sentence)))))
	(if (or (equalp target "around") (equal target ""))
	 (setf target (third (gethash "me" *objects*))))
	(if (lookable target)
	 (let ((objhash (gethash target *objects*)))
		(describe-thing objhash)
		(list-contents objhash))
	 (format t "You don't see a ~a here.~%" target))))

(add-command "look" #'do-look)
