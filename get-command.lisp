; author: Dan Stanton
(load "string-tokenize.lisp")

(defun prompt-read (prompt)
 "prints 'prompt' and returns a line from standard input
 taken from Practical Common Lisp chapter 3"
 (format *query-io* "~a: " prompt)
 (force-output *query-io*)
 (read-line *query-io*))

(defun get-command ()
 "basic prompt for command entry"
 (space-tokenize (prompt-read "do--> ")))

(defun get-choice (prompt)
 "gets the user's choice"
 (or (parse-integer 
	(prompt-read prompt) :junk-allowed t) 0))

