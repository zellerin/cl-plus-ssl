(in-package :cl+ssl.test)

(def-suite :cl+ssl.alpn :in :cl+ssl
  :description "ALPN tests")

(in-suite :cl+ssl.alpn)

(test alpn-client
  (flet ((test-alpn-result (target proposed expected)
	   (usocket:with-client-socket (socket stream target 443)
	     (is
	      (equal expected
		     (cl+ssl:get-selected-alpn-protocol
		      (cl+ssl:make-ssl-client-stream stream :alpn-protocols proposed)))))))
    (test-alpn-result "example.com" nil nil)
    (test-alpn-result "example.com" '( "should-not-exist" "h2" "also-should-not-exist")
		      "h1")))
