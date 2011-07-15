; author: Dan Stanton
(defvar *objects* (make-hash-table :test 'equalp))

(defmacro create-add-object (parameters)
  `(defun add-object (name &key ,@(remove 'nil parameters))
     (setf (gethash name *objects*) (list ,@parameters))
     (when holder
       (let ((container (gethash holder *objects*)))
         (setf (fourth container)
               (cons name (fourth container)))))))

(load "object-design.lisp")

(let ((objs (open "objects.dat" :if-does-not-exist nil)))
  (when objs
    (loop for object = (read objs nil)
          while object do (apply #'add-object object))
    (close objs)
    (format t "Objects loaded~%")))
