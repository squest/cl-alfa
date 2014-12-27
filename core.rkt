#lang racket

(require web-server/templates
	 (planet dmac/spin))

(get "/"
     (lambda ()
       (let ((nama "Wookie!"))
	 (include-template "base.html"))))

(run #:port 3000)
