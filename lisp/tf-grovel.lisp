;;;; -*- mode: lisp -*-
;;;;
;;;; Copyright (c) 2017, Rice University
;;;; All rights reserved.
;;;;
;;;; Author(s): Neil T. Dantam <ntd@gatech.edu>
;;;;
;;;;   Redistribution and use in source and binary forms, with or
;;;;   without modification, are permitted provided that the following
;;;;   conditions are met:
;;;;
;;;;   * Redistributions of source code must retain the above
;;;;     copyright notice, this list of conditions and the following
;;;;     disclaimer.
;;;;   * Redistributions in binary form must reproduce the above
;;;;     copyright notice, this list of conditions and the following
;;;;     disclaimer in the documentation and/or other materials
;;;;     provided with the distribution.
;;;;   * Neither the name of copyright holder the names of its
;;;;     contributors may be used to endorse or promote products
;;;;     derived from this software without specific prior written
;;;;     permission.
;;;;
;;;;   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
;;;;   CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
;;;;   INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
;;;;   MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
;;;;   DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
;;;;   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;;;;   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
;;;;   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
;;;;   USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
;;;;   AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
;;;;   LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
;;;;   ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;;

(progn
  (in-package :amino)
  ;; Look for source directory includes
  (cc-flags #.(concatenate 'string "-I"
                           (namestring (asdf:system-source-directory :amino))
                           "../include")
            #.(when (boundp 'cl-user::*top-srcdir*)
                (concatenate 'string "-I"
                             cl-user::*top-srcdir*
                             "/include"))
            #.(when (boundp 'cl-user::*top-builddir*)
                (concatenate 'string "-I"
                             cl-user::*top-builddir*
                             "/include"))
            "-std=gnu99")

  (include "amino.h")

  ;; Quat
  (constant (+tf-quat-v+ "AA_TF_QUAT_V")
            :type integer)
  (constant (+tf-quat-x+ "AA_TF_QUAT_X")
            :type integer)
  (constant (+tf-quat-y+ "AA_TF_QUAT_Y")
            :type integer)
  (constant (+tf-quat-z+ "AA_TF_QUAT_Z")
            :type integer)
  (constant (+tf-quat-w+ "AA_TF_QUAT_W")
            :type integer)


  ;; QuTr
  (constant (+tf-qutr-q+ "AA_TF_QUTR_Q")
            :type integer)
  (constant (+tf-qutr-t+ "AA_TF_QUTR_T")
            :type integer)

  ;; DuQu
  (constant (+tf-duqu-real+ "AA_TF_DUQU_REAL")
            :type integer)
  (constant (+tf-duqu-dual+ "AA_TF_DUQU_DUAL")
            :type integer)


  ;; DX
  (constant (+tf-dx-v+ "AA_TF_DX_V")
            :type integer)
  (constant (+tf-dx-w+ "AA_TF_DX_W")
            :type integer)

  )
