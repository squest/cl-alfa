(ql:quickload :one)

(defpackage one.app
  (:use :cl)
  (:import-from :clack
                :call)
  (:import-from :clack.builder
                :builder)
  (:import-from :clack.middleware.static
                :<clack-middleware-static>)
  (:import-from :clack.middleware.session
                :<clack-middleware-session>)
  (:import-from :clack.middleware.accesslog
                :<clack-middleware-accesslog>)
  (:import-from :clack.middleware.backtrace
                :<clack-middleware-backtrace>)
  (:import-from :ppcre
                :scan
                :regex-replace)
  (:import-from :one.web
                :*web*)
  (:import-from :one.config
                :config
                :productionp
                :*static-directory*))
(in-package :one.app)

(builder
 (<clack-middleware-static>
  :path (lambda (path)
          (if (ppcre:scan
	       "^(?:/images/|/css/|/js/|/robot\\.txt$|/favicon.ico$)"
	       path)
              path
              nil))
  :root *static-directory*)
 (if (productionp)
     nil
     (make-instance '<clack-middleware-accesslog>))
 (if (getf (config) :error-log)
     (make-instance '<clack-middleware-backtrace>
                    :output (getf (config) :error-log))
     nil)
 <clack-middleware-session>
 (if (productionp)
     nil
     (lambda (app)
       (lambda (env)
         (let ((datafly:*trace-sql* t))
           (call app env)))))
 *web*)









