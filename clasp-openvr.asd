#|
  This file is a part of clasp-openvr project.
  Copyright (c) 2019 Selwyn Simsek (sgs16@ic.ac.uk)
|#

#|
  Clasp Common Lisp bindings for the OpenVR library

  Author: Selwyn Simsek (sgs16@ic.ac.uk)
|#

(defsystem "clasp-openvr"
  :version "0.1.0"
  :author "Selwyn Simsek"
  :license "LLGPL"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "clasp-openvr"))))
  :description "Clasp Common Lisp bindings for the OpenVR library"
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "clasp-openvr-test"))))
