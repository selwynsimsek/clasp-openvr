# Clasp-Openvr - Clasp Common Lisp bindings for the OpenVR library

[OpenVR](https://github.com/ValveSoftware/openvr) is a C++ API that allows one to address underlying VR hardware without using a vendor specific API. This library exposes OpenVR to [Clasp Common Lisp](https://github.com/clasp-developers/clasp), a Common Lisp implementation designed with C++ interoperation in mind.

You may also like to check out [3b-openvr](https://github.com/3b/3b-openvr).

## Usage

Load src/generate.lisp to regenerate the bindings.

./make.sh will compile src/exposeOpenVR.cc to bitcode which can be loaded into the Clasp image.

## Author

* Selwyn Simsek (sgs16@ic.ac.uk)

## Copyright

Copyright (c) 2019 Selwyn Simsek (sgs16@ic.ac.uk)

## License

Licensed under the LLGPL License.
