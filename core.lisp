(ql:quickload (list "wookie" "cl-who"))

(defpackage :hello-world
  (:use :cl :wookie :who))

(in-package :hello-world)

(load-plugins)

(defun homepage ()
  (with-html-output-to-string (s)
    (:html
     (:center
      (:h1 "Helloow world from wookie")))))

(defroute (:get "/") (req res)
  (send-response
   res
   :body
   (homepage)))

(as:with-event-loop ()
  (start-server (make-instance 'listener :port 3000)))


