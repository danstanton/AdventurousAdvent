; author: Dan Stanton
; course: CSC 630
; final project
; This is the beginning of Adventurous Advent, a text adventure engine
; written in Lisp.
(load "get-command.lisp")
(load "objects.lisp")
(load "commands.lisp")

(defun introduction () 
  "give an example command for the player"
  (format t "do--> : look around~%"))

(defun show-menu ()
  "displays the main menu"
  (format t "
	 1. New game
	 2. Reload objects
	 3. Reload commands
	 4. Exit~%"))

(defun run-command (quit sentence)
 (let (( current-command (gethash (first sentence) *commands*)))
	(if current-command
	 (funcall current-command sentence)
	 (when (equalp "quit" (first sentence)) (funcall quit)))))

(defun start-adventure () 
  (introduction)
  (run-command #'(lambda () ) (list "look" "around"))
  (loop 
    (run-command #'(lambda () (return-from start-adventure T)) 
                 (get-command))))

(defun main-menu ()
  "presents menu choice and executes choice"
  (loop 
    (show-menu)
    (let ((choice (get-choice "the great One chooses: "))) 
      (cond
        ((equal choice 1) (start-adventure))
        ((equal choice 2) (load "objects.lisp"))
		((equal choice 3) (load "commands.lisp"))
        ((equal choice 4) (return T)))))
	(format t "Good bye!"))
