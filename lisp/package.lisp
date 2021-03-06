;;;; -*- mode: lisp -*-
;;;;
;;;; Copyright (c) 2013, Georgia Tech Research Corporation
;;;; All rights reserved.
;;;;
;;;; Author(s): Neil T. Dantam <ntd@gatech.edu>
;;;; Georgia Tech Humanoid Robotics Lab
;;;; Under Direction of Prof. Mike Stilman <mstilman@cc.gatech.edu>
;;;;
;;;;
;;;; This file is provided under the following "BSD-style" License:
;;;;
;;;;
;;;;   Redistribution and use in source and binary forms, with or
;;;;   without modification, are permitted provided that the following
;;;;   conditions are met:
;;;;
;;;;   * Redistributions of source code must retain the above copyright
;;;;     notice, this list of conditions and the following disclaimer.
;;;;
;;;;   * Redistributions in binary form must reproduce the above
;;;;     copyright notice, this list of conditions and the following
;;;;     disclaimer in the documentation and/or other materials provided
;;;;     with the distribution.
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
;;;;   POSSIBILITY OF SUCH DAMAGE.

(defpackage :amino-type
  (:use :cl :cffi :alexandria)
  (:export
   ;; real-array
   :vec
   :real-array
   :make-real-array
   :real-array-data
   ;; matrix
   :matrix
   :%make-matrix
   :%matrix-data
   :%matrix-offset
   :%matrix-stride
   :%matrix-cols
   :%matrix-rows
   ;; Sparse
   :make-crs-matrix
   ;; conditions
   :matrix-storage-error
   :matrix-dimension-error
   :check-matrix-bounds
   :check-matrix-dimensions
   ))


(defpackage :amino-ffi
  (:use :cl :cffi :alexandria :amino-type)
  (:export
   ;; macros
   :def-ref-type
   :with-reference
   :with-foreign-matrix
   :with-foreign-vector
   :with-foreign-simple-vector
   :with-foreign-fixed-vector
   :def-la-cfun
   :def-blas-cfun
   ;; foreign types
   :size-t
   :int-ref-t :double-ref-t :float-ref-t :size-ref-t :char-ref-t
   ;; BLAS
   :blas-size-t :blas-size-ref-t
   :def-blas-cfun
   :transpose-t
   ;; libc
   :libc-malloc
   :libc-free
   :libc-realloc
   :libc-memcpy
   ))

(defpackage :amino
  (:use :cl :cffi :alexandria :amino-type :amino-ffi :sycamore :sycamore-util)
  (:export
   ;; General types
   :vec
   :fnvec
   :vec
   :make-vec
   :make-fnvec
   :vecref :vec-x :vec-y :vec-z :vec-w
   :vec-cat
   :vec-list
   :vec-sequence
   :vec-flatten
   :fnvec-flatten
   :make-matrix
   :matref
   :ensure-vec
   ;; vec ops
   :vec-ssd
   :vec-dist
   :vec-norm
   ;; Sparse
   :make-crs-matrix
   ;; TF Types
   :+tf-ident+
   :vec3 :vec3*
   :with-vec3 :vec3-identity-p
   :vec3-normalize
   :axis-angle :axis-angle*
   :quaternion :quaternion* :quaternion-x :quaternion-y :quaternion-z :quaternion-w
   :with-quaternion :quaternion-identity-p
   :rotation-matrix
   :euler-zyx :euler-zyx*
   :euler-rpy :euler-rpy*
   :dual-quaternion :quaternion-translation :transformation-matrix
   :dual-quaternion-2 :quaternion-translation-2 :transformation-matrix-2
   :quaternion-translation*
   :tf-readable :tf-readable*
   :x-angle :y-angle :z-angle
   :degrees :pi-rad
   :translation
   :rotation
   :normalize
   :tf-tag
   :tf-tag-parent :tf-tag-child :tf-tag-tf
   :cross
   :quaternion-from-vectors
   :tf
   :tf*
   :tf-inverse
   :tf-array
   :tf-mul
   :tf-copy
   :tf-normalize
   :tf-translation
   :tf-quaternion
   :tf-rotation
   :identity-quaternion
   :identity-vec3
   :identity-tf
   ;; TF tree
   :make-tf-tree
   :tf-tree-insert
   :tf-tree-remove
   :tf-tree-find
   :tf-tree-absolute-tf
   ;; Generics
   :transform
   :g*
   :g+
   :g-
   :g/
   :matrix->list
   :inverse
   ;; Misc
   :parse-float
   ;; optimization
   :linear-term
   :quadratic-term
   :lp
   :with-linear-term
   :with-quadratic-term
   :with-constraint
   :opt-constraint
   :opt-constraint-bounds
   :optexp
   :optexp-add-bounds
   :optexp-add-constraint
   :optexp=
   :optexp>=
   :optexp<=
   :optexp-add-constraint-exp
   :optexp-add-objective
   :optexp-set-integer
   :optexp-set-binary
   :optexp-solve
   )
  (:nicknames :aa))
