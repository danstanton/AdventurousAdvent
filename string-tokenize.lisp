; author: Dan Stanton
(defun string-tokenize (string test-delim)
  "returns a list of the words of 'string', where the words were separated according to test-delim 
  'test-delim' takes the current character as input and returns T at the beginning of a delimiter and nil at the end of a delimiter
  modified from the Common Lisp Cookbook at http://cl-cookbook.sourceforge.net/strings.html#reverse."
  (loop 
    for i = (position-if-not test-delim string :start 0) ; i is non-delim
    then (position-if-not test-delim string :start j)
    while i
    for j = (position-if test-delim string :start i) ; j is at next delim 
    collect (subseq string i j)
    while j)) ; position returns nil if no next space

(defun space-tokenize (string) 
  "returns a list of the space-separated words of string"
  (string-tokenize string #'(lambda (char) (equal char #\Space))))

(defun space-concat ( words )
  (let ((result ""))
    (loop for word in words
	  do (setf result (concatenate 'string result word " ")))
    (setf result (string-trim " " result))
    (return-from space-concat result)))

(defun remove-lots (sequence &rest words)
  (let ((newseq sequence))
    (loop for word in words
	  do (setf newseq (remove word newseq :test #'equalp)))
    (return-from remove-lots newseq)))

(defun remove-common (sequence)
  (remove-lots sequence "to" "a" "the" "an" "at" "over"))
