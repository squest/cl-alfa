(in-package :cl-user)
(defpackage caveweb-test-asd
  (:use :cl :asdf))
(in-package :caveweb-test-asd)

(defsystem caveweb-test
  :author "squest"
  :license ""
  :depends-on (:caveweb
               :cl-test-more)
  :components ((:module "t"
                :components
                ((:file "caveweb"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
