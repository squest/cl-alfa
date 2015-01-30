(in-package :cl-user)
(defpackage one-test-asd
  (:use :cl :asdf))
(in-package :one-test-asd)

(defsystem one-test
  :author "SQuest"
  :license ""
  :depends-on (:one
               :cl-test-more)
  :components ((:module "t"
                :components
                ((:file "one"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
