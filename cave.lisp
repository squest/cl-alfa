(ql:quickload :caveman2)

(defpackage cave-web
  (:use :cl :caveman2))

(in-package cave-web)

(defroute "/" ()
  (lambda () (string "Hellow world!")))


