; author: Dan Stanton
(defvar *commands* (make-hash-table :test 'equalp))

(defun add-command (name fn)
 (setf (gethash name *commands*) fn))

(let (( command-files (directory (make-pathname :name :wild :type "lisp" :defaults "./commands/"))))
 (loop for file in command-files
	do (load file)))
