(ql:quickload (list "restas" "cl-who"))

(restas:define-module #:hello-world
  (:use :cl :restas :who))

(in-package :hello-world)

(defun homepage ()
  (with-html-output-to-string (s)
    (:html
     (:center
      (:h1 "Helloow world from restas")))))

(define-route hello ("")
  (homepage))

(start '#:hello-world :port 3000)


