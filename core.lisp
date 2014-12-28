(ql:quickload (list "restas" "cl-who" "cl-redis"))

(restas:define-module #:lispyway
  (:use :cl :restas :who :redis))

(in-package :lispyway)

(defun cstr (&rest args)
  (apply 'concatenate 'string
	 (mapcar #'(lambda (x) (if (stringp x) x
			      (write-to-string x)))
		 args)))

(defun homepage ()
  "The homepage"
  (let ((lim 200))
    (with-html-output-to-string (s)
      (:html
       (:head
	(:title "Hello world"))
       (:body
	(:header)
	(:center
	 (let ((nama "John Paul isPrime"))
	   (htm (:h1 (str (cstr "Hellow world from restas " nama))
		     (:br)
		     (:h3 (str (cstr "As you can see, this is a test page "
				     "for daemonized sbcl, restas, cl-who, and redis"))))))
	 (:ul
	  (mapcar
	   #'(lambda (x)
	       (let* ((res (read-from-string (red:get (cstr "prime" x))))
		      (numstat (getf res 'statprime))
		      (num (cstr "The number "
				 (getf res 'number)
				 " prime status "
				 numstat)))
		 (htm (:li (str num)))))
	   (loop for i from 2 to lim collect i))))
	(:footer))))))


(define-route lispy-home ("/")
  (homepage))

(defun run (port)
  (progn (start '#:lispyway :port port)
	 (connect)
	 (cstr "Restas listening on port " port)))

(defun prime? (p)
  (labels ((looper (i)
	      (if (> (* i i) p)
		  t
		  (if (zerop (rem p i))
		      nil
		      (looper (+ i 2))))))
    (cond ((= 2 p) t)
	  ((evenp p) nil)
	  (t (looper 3)))))

(defun into-redis (lim)
  (loop for i from 2 to lim 
     do (red:set (cstr "prime" i)
		 (list "Number" i "Statprime" (if (prime? i) "yoih" "nooo")))))

(defun stop ()
  (progn (disconnect)
	 (stop-all)))
