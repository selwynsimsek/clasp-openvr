#|
  This file is a part of clasp-openvr project.
  Copyright (c) 2019 Selwyn Simsek (sgs16@ic.ac.uk)
|#

(defsystem "clasp-openvr-test"
  :defsystem-depends-on ("prove-asdf")
  :author "Selwyn Simsek"
  :license "LLGPL"
  :depends-on ("clasp-openvr"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "clasp-openvr"))))
  :description "Test system for clasp-openvr"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
