(in-package :cl-user)
(defpackage one.web
  (:use :cl
        :caveman2
        :one.config
        :one.view
        :one.db
        :datafly
        :sxql)
  (:export :*web*))
(in-package :one.web)

;;
;; Application

(defclass <web> (<app>) ())
(defvar *web* (make-instance '<web>))
(clear-routing-rules *web*)

;;
;; Routing rules

(defroute "/" ()
  (with-layout (:title "Welcome to Caveman2")
    (render #P"index.tmpl")))

;;
;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))
