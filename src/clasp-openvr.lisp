(defpackage clasp-openvr
  (:use :cl))
(in-package :clasp-openvr)

(progn
  (core:dlopen #+darwin "/usr/local/lib/libopenvr_api.dylib"
               #+linux "/usr/local/lib/libopenvr.so")) ;; Clasp Common Lisp not supported on Windows


;;;
;;; Load the code that binds OpenVR to Clasp Common Lisp
;;;

(load (merge-pathnames #P"exposeVR.bc" *load-truename*))
