#!/bin/bash
cd src
rm exposeOpenVR.cc
rm clasp-openvr.lisp
clasp --load generate.lisp --eval '(core:quit)'
CLANG=clang-6.0
CLASP_HOME=~/lisp/clasp
CLASP_RUNTIME=boehm
LLVM_INCLUDE_DIR=`llvm-config --includedir`
OPTIONS="-v -I$CLASP_HOME/include  -I$CLASP_HOME/src/main  -I$CLASP_HOME/include/clasp/main  -I$CLASP_HOME/build/$CLASP_RUNTIME  -I$CLASP_HOME/build/$CLASP_RUNTIME/generated  -I$LLVM_INCLUDE_DIR   -c -emit-llvm  -Wno-macro-redefined  -Wno-deprecated-register  -Wno-inconsistent-missing-override"

$CLANG $OPTIONS -o ../clbind/exposeOpenVR.bc exposeOpenVR.cc

