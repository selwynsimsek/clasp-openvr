;; inspired by cl-vulkan

(ql:quickload :cl-json)
(ql:quickload :iterate)
(defpackage :clasp-openvr-gen (:use :cl :iterate))
(in-package :clasp-openvr-gen)

(defvar *base-dir* (make-pathname :directory (pathname-directory
                                              (or *compile-file-pathname*
                                                  *load-pathname*))))
(defvar *relative-spec* (make-pathname :directory '(:relative :up "spec")))
(defvar *spec-dir* (merge-pathnames *relative-spec* *base-dir*))
(defvar *api-json-pathname* (merge-pathnames *spec-dir* "openvr_api.json"))
(defvar *clbind-file-output* (merge-pathnames *base-dir* "exposeOpenVR.cc"))
(defvar *lisp-file-output* (merge-pathnames *base-dir* "clasp-openvr.lisp"))

(defvar *api-json* (cl-json:decode-json-from-source *api-json-pathname*))

(assert (every #'identity (mapcar #'eq (mapcar #'car *api-json*)
                                  '(:typedefs :enums :consts :structs :methods))))
;; otherwise the JSON manifest format has changed

(defvar *clbind-start-message* "// autogenerated by clasp-openvr: do not edit~%~%~%")
(defvar *clbind-end-message* "~%~%// end of file~%")
(defvar *typedefs* (cdr (first *api-json*)))
(defvar *enums* (cdr (second *api-json*)))
(defvar *consts* (cdr (third *api-json*)))
(defvar *structs* (cdr (fourth *api-json*)))
(defvar *methods* (cdr (fifth *api-json*)))
(defvar *includes* '("<clasp/clasp.h>" "<clasp/clbind/clbind.h>"))

(defun emit-includes ()
  (format t "~{#include ~a~%~}~%" *includes*))

(defmacro namespace (namespace &rest body)
  `(progn (format t "namespace ~a { ~%" ,namespace)
          ,@body
          (format t "};~%")))

(defun emit-typedefs ()
  ;;do nothing - C++ already knows the typedefs.
  ;; use them to generate translate bindings?
  )

(defun emit-enums ()
                                        ;code here
  )

;;archimag/cl-closure-template
(defun lispify-string (str)
  (coerce (iter (for ch in-string str)
                (for prev-char previous ch)
                (when (and (upper-case-p ch) prev-char (or (digit-char-p prev-char)
                                                           (lower-case-p prev-char)))
                  (collect #\-))
            (if (char= ch #\_)
                (collect #\-)
                (collect (char-downcase ch))))
          'string))

(defun convert-type (value) (or (parse-integer value :junk-allowed t) value)) ;; all consts are either some type of integer or a string. Clasp clbind should take care of the translation automatically (check this?)

(defun emit-consts ()                                      ;code here
  (format t "~%(defpackage clasp-openvr (:use :cl) (:export ~{ #:~a~}))~%(in-package :clasp-openvr)~%~{(defvar ~{~a~^ ~s~})~%~}"
          (mapcar (lambda (const) (lispify-string (cdar const))) *consts*)
          (mapcar (lambda (const) (list (lispify-string (cdar const))
                                        (convert-type (cdaddr const)))) *consts* )))

(defun emit-structs ()
                                        ;code here
  )
(defun emit-methods ()
                                        ;code here
  )

(defun write-clbind-file ()
  (with-open-file (*standard-output* *clbind-file-output*
                                     :direction :output
                                     :if-exists :overwrite
                                     :if-does-not-exist :create)
    (format t *clbind-start-message*)
    (emit-includes)
    (emit-typedefs)
    (emit-enums)
    (emit-structs)
    (emit-methods)
    (format t *clbind-end-message*))
  (with-open-file (*standard-output* *lisp-file-output*
                                     :direction :output
                                     :if-exists :overwrite
                                     :if-does-not-exist :create)
    (format t ";;; autogenerated - do not edit~%;;; consts from clbind_api.json~%~%")
    (emit-consts)
    (format t ";; end of file~%")))

(write-clbind-file)
