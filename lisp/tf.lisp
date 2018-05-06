;;;; -*- mode: lisp -*-
;;;;
;;;; Copyright (c) 2013, Georgia Tech Research Corporation
;;;; Copyright (c) 2015, Rice University
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


(in-package :amino)

(defparameter +tf-quat-ident+ (make-quaternion :data (vec 0 0 0 1))
  "An identity quaternion")

(defparameter +tf-duqu-ident+ (make-dual-quaternion :data (vec 0 0 0 1
                                                               0 0 0 0))
  "An identity dual quaternion")

(defparameter +tf-vec-3-ident+ (vec3* 0 0 0)
  "An \"identity\" vector, i.e., zero-valued.")

(defparameter +tf-ident+ (make-quaternion-translation :quaternion +tf-quat-ident+
                                                      :translation +tf-vec-3-ident+)
  "An identity transformation.")


;;; Identities ;;;

(declaim (inline identity-quaternion))
(defun identity-quaternion ()
  "Return the identity quaternion."
  +tf-quat-ident+)


(declaim (inline identity-vec3))
(defun identity-vec3 ()
  "Return the \"identity\" 3-vector."
  +tf-vec-3-ident+)

(declaim (inline identity-tf))
(defun identity-tf ()
  "Return the identity transform."
  +tf-ident+)

(defcfun aa-tf-cross :void
  (a vector-3-t)
  (b vector-3-t)
  (c vector-3-t))

(defun cross (a b &optional (c (make-vec3)))
  "Compute the cross product of vector-3 A and B."
  (aa-tf-cross a b c)
  c)



;;; Matrices

(defcfun aa-tf-9 :void
  (tf rotation-matrix-t)
  (p0 vector-3-t)
  (p1 vector-3-t))
(defun tf-9 (tf p0 &optional (p1 (make-vec3)))
  (aa-tf-9 tf p0 p1)
  p1)


(defcfun aa-tf-12 :void
  (tf transformation-matrix-t)
  (p0 vector-3-t)
  (p1 vector-3-t))
(defun tf-12 (tf p0 &optional (p1 (make-vec3)))
  (aa-tf-12 tf p0 p1)
  p1)


(defcfun aa-tf-12chain :void
  (tf1 transformation-matrix-t)
  (tf2 transformation-matrix-t)
  (tf transformation-matrix-t))
(defun tf-12chain (tf1 tf2 &optional (tf (make-transformation-matrix)))
  (aa-tf-12chain tf1 tf2 tf)
  tf)

(defcfun aa-tf-xangle2rotmat :void
  (theta :double)
  (r rotation-matrix-t))
(defun tf-xangle2rotmat (theta &optional (r (make-rotation-matrix)))
  (aa-tf-xangle2rotmat theta r)
  r)

(defcfun aa-tf-yangle2rotmat :void
  (theta :double)
  (r rotation-matrix-t))
(defun tf-yangle2rotmat (theta &optional (r (make-rotation-matrix)))
  (aa-tf-yangle2rotmat theta r)
  r)

(defcfun aa-tf-zangle2rotmat :void
  (theta :double)
  (r rotation-matrix-t))
(defun tf-zangle2rotmat (theta &optional (r (make-rotation-matrix)))
  (aa-tf-zangle2rotmat theta r)
  r)

(defcfun aa-tf-axang2rotmat :void
  (a axis-angle-t)
  (r rotation-matrix-t))
(defun tf-axang2rotmat (a &optional (r (make-rotation-matrix)))
  (aa-tf-axang2rotmat a r)
  r)


(defcfun aa-tf-12inv :void
  (tf transformation-matrix-t)
  (tf-i transformation-matrix-t))
(defun tf-inv (tf &optional (tf-i (make-transformation-matrix)))
  (aa-tf-12inv tf tf-i))

(defcfun aa-tf-12rel :void
  (tf1 transformation-matrix-t)
  (tf2 transformation-matrix-t)
  (tf transformation-matrix-t))
(defun tf-rel (tf1 tf2 &optional (tf (make-transformation-matrix)))
  (aa-tf-12rel tf1 tf2 tf)
  tf)

(defcfun aa-tf-rotmat-mul :void
  (a rotation-matrix-t)
  (b rotation-matrix-t)
  (c rotation-matrix-t))

(defun tf-rotmat-mul (a b &optional (c (make-rotation-matrix)))
  (aa-tf-rotmat-mul a b c)
  c)

(defcfun aa-tf-rotmat-xy :void
  (x-axis vector-3-t)
  (y-axis vector-3-t)
  (r rotation-matrix-t))

(defcfun aa-tf-rotmat-yz :void
  (y-axis vector-3-t)
  (z-axis vector-3-t)
  (r rotation-matrix-t))

(defcfun aa-tf-rotmat-zx :void
  (z-axis vector-3-t)
  (x-axis vector-3-t)
  (r rotation-matrix-t))

(defun tf-rotmat-xy (x-axis y-axis &optional (rotmat (make-rotation-matrix)))
  (aa-tf-rotmat-xy x-axis y-axis rotmat)
  rotmat)

(defun tf-rotmat-yz (y-axis z-axis &optional (rotmat (make-rotation-matrix)))
  (aa-tf-rotmat-yz y-axis z-axis rotmat)
  rotmat)

(defun tf-rotmat-zx (z-axis x-axis &optional (rotmat (make-rotation-matrix)))
  (aa-tf-rotmat-zx z-axis x-axis rotmat)
  rotmat)

(defun rotation-matrix-x-axis (r)
  (vec3* (matref r 0 0)
         (matref r 1 0)
         (matref r 2 0)))

(defun rotation-matrix-y-axis (r)
  (vec3* (matref r 0 1)
         (matref r 1 1)
         (matref r 2 1)))

(defun rotation-matrix-z-axis (r)
  (vec3* (matref r 0 2)
         (matref r 1 2)
         (matref r 2 2)))

(defcfun aa-tf-tfmat-lnv :void
  (m transformation-matrix-t)
  (v :pointer))

(defun tf-tfmat-lnv (m &optional (v (make-vec 6)))
  (assert (= (length v) 6))
  (with-pointer-to-vector-data (v v)
    (aa-tf-tfmat-lnv m v))
  v)


;;; Quaternions
(defmacro def-q2 ((c-fun lisp-fun) doc-string)
  `(progn (defcfun ,c-fun :void
            (x quaternion-t)
            (y quaternion-t))
          (defun ,lisp-fun (x &optional (y (make-quaternion)))
            ,doc-string
            (,c-fun x y)
            y)))

(defmacro def-q3 ((c-fun lisp-fun) doc-string)
  `(progn (defcfun ,c-fun :void
            (x1 quaternion-t)
            (x2 quaternion-t)
            (y quaternion-t))
          (defun ,lisp-fun (x1 x2 &optional (y (make-quaternion)))
            ,doc-string
            (,c-fun x1 x2 y)
            y)))

(def-q2 (aa-tf-qconj tf-qconj) "Quaternion conjugate")
(def-q2 (aa-tf-qinv tf-qinv) "Quaternion inverse")
(def-q2 (aa-tf-qnormalize2 tf-qnormalize) "Normalize unit quaternion")
(def-q2 (aa-tf-qminimize2 tf-qminimize) "Minimum angle unit quaternion")
(def-q2 (aa-tf-qexp tf-qexp) "Quaternion exponential")
(def-q2 (aa-tf-qln tf-qln) "Quaternion logarithm")

(def-q2 (aa-tf-qexp-n tf-qexp-n) "Quaternion exponential alternate version")

(def-q3 (aa-tf-qadd tf-qadd) "Add two quaternions")
(def-q3 (aa-tf-qsub tf-qsub) "Subtract quaternions")
(def-q3 (aa-tf-qmul tf-qmul) "Multiply quaternions")
(def-q3 (aa-tf-qcmul tf-qcmul) "Multiply conjugate of first arg with second arg")
(def-q3 (aa-tf-qmulc tf-qmulc) "Multiply first arg with conjugate of second arg")

(defcfun ("aa_tf_qnorm" tf-qnorm) :double
  (q quaternion-t))

(defcfun aa-tf-qpow :void
  (q quaternion-t)
  (a :double)
  (r quaternion-t))

(defun tf-qpow (q power)
  (let ((r (make-quaternion)))
    (aa-tf-qpow q (coerce power 'double-float) r)
    r))

(defcfun aa-tf-qrot :void
  (q quaternion-t)
  (p0 vector-3-t)
  (p1 vector-3-t))
(defun tf-qrot (q p0 &optional (p1 (make-vec3)))
  "Quaternion spherical linear interpolation"
  (aa-tf-qrot q p0 p1)
  p1)

(defcfun aa-tf-qslerp :void
  (r :double)
  (q0 quaternion-t)
  (q1 quaternion-t)
  (q quaternion-t))
(defun tf-qslerp (r q0 q1 &optional (q (make-quaternion)))
  "Quaternion spherical linear interpolation"
  (aa-tf-qslerp r q0 q1 q)
  q)

(defcfun aa-tf-qsvel :void
  (q0 quaternion-t)
  (w vector-3-t)
  (dt :double)
  (q1 quaternion-t))
(defun tf-qsvel (q0 w dt &optional (q1 (make-quaternion)))
  "Integrate unit quaternion rotational velocity"
  (aa-tf-qsvel q0 w dt q1)
  q1)


(defcfun aa-tf-qvelrk1 :void
  (q0 quaternion-t)
  (w vector-3-t)
  (dt :double)
  (q1 quaternion-t))
(defun tf-qvelrk1 (q0 w dt &optional (q1 (make-quaternion)))
  "Integrate unit quaternion rotational velocity"
  (aa-tf-qvelrk1 q0 w dt q1)
  q1)

(defcfun aa-tf-qvelrk4 :void
  (q0 quaternion-t)
  (w vector-3-t)
  (dt :double)
  (q1 quaternion-t))
(defun tf-qvelrk4 (q0 w dt &optional (q1 (make-quaternion)))
  "Integrate unit quaternion rotational velocity"
  (aa-tf-qvelrk4 q0 w dt q1)
  q1)

(defcfun aa-tf-qvel2diff :void
  (q quaternion-t)
  (w vector-3-t)
  (dq quaternion-t))
(defun tf-qvel2diff (q w &optional (dq (make-quaternion)))
  "Velocity to quaternion derivative"
  (aa-tf-qvel2diff q w dq)
  dq)

(defcfun aa-tf-qdiff2vel :void
  (q quaternion-t)
  (dq quaternion-t)
  (w vector-3-t))
(defun tf-qdiff2vel (q dq &optional (w (make-vec3)))
  "Velocity to quaternion derivative"
  (aa-tf-qdiff2vel q dq w)
  w)


(defcfun aa-tf-rotmat2quat :void
  (r rotation-matrix-t)
  (q quaternion-t))
(defun tf-rotmat2quat (r &optional (q (make-quaternion)))
  "Convert rotation matrix to quaternion"
  (aa-tf-rotmat2quat r q)
  q)

(defcfun aa-tf-quat2rotmat :void
  (q quaternion-t)
  (r rotation-matrix-t))
(defun tf-quat2rotmat (q &optional (r (make-matrix 3 3)))
  "Convert quaternion to rotation matrix"
  (aa-tf-quat2rotmat q r)
  r)


(defcfun aa-tf-quat2rotvec :void
  (q quaternion-t)
  (r rotation-vector-t))
(defun tf-quat2rotvec (q &optional (r (make-rotation-vector)))
  "Convert quaternion to rotation matrix"
  (aa-tf-quat2rotvec q r)
  r)


(defcfun aa-tf-quat2axang :void
  (q quaternion-t)
  (r axis-angle-t))
(defun tf-quat2axang (q &optional (a (make-axis-angle)))
  "Convert quaternion to rotation matrix"
  (aa-tf-quat2axang q a)
  a)

(defcfun aa-tf-xangle2quat :void
  (theta :double)
  (r quaternion-t))
(defun tf-xangle2quat (theta &optional (r (make-quaternion)))
  "Convert rotation about x to unit quaternion"
  (aa-tf-xangle2quat theta r)
  r)

(defcfun aa-tf-yangle2quat :void
  (theta :double)
  (r quaternion-t))
(defun tf-yangle2quat (theta &optional (r (make-quaternion)))
  "Convert rotation about y to unit quaternion"
  (aa-tf-yangle2quat theta r)
  r)

(defcfun aa-tf-zangle2quat :void
  (theta :double)
  (r quaternion-t))
(defun tf-zangle2quat (theta &optional (r (make-quaternion)))
  "Convert rotation about z to unit quaternion"
  (aa-tf-zangle2quat theta r)
  r)

(defcfun aa-tf-axang2quat :void
  (a axis-angle-t)
  (r quaternion-t))
(defun tf-axang2quat (a &optional (r (make-quaternion)))
  (aa-tf-axang2quat a r)
  r)

(defcfun aa-tf-vecs2quat :void
  (a vector-3-t)
  (b vector-3-t)
  (c quaternion-t))

(defun quaternion-from-vectors (u v &optional (q (make-quaternion)))
  "Find the unit quaternion representing the rotation from U to V."
  (aa-tf-vecs2quat u v q)
  q)

;;; Dual quaternion


(defmacro def-dq2 ((c-fun lisp-fun) doc-string)
  `(progn (defcfun ,c-fun :void
            (x dual-quaternion-t)
            (y dual-quaternion-t))
          (defun ,lisp-fun (x &optional (y (make-dual-quaternion)))
            ,doc-string
            (,c-fun x y)
            y)))

(defmacro def-dq3 ((c-fun lisp-fun) doc-string)
  `(progn (defcfun ,c-fun :void
            (x1 dual-quaternion-t)
            (x2 dual-quaternion-t)
            (y dual-quaternion-t))
          (defun ,lisp-fun (x1 x2 &optional (y (make-dual-quaternion)))
            ,doc-string
            (,c-fun x1 x2 y)
            y)))

(defcfun aa-tf-duqu-trans :void
  (d dual-quaternion-t)
  (x vector-3-t))
(defun tf-duqu-trans (d &optional (x (make-vec3)))
  "Extract dual quaternion translation"
  (aa-tf-duqu-trans d x)
  x)

(defun tf-duqu-rot (d &optional (r (make-quaternion)))
  "Extration dual quaternion rotation"
  (replace (quaternion-data r)
           (dual-quaternion-data d))
  r)

(defcfun aa-tf-qv2duqu :void
  (q quaternion-t)
  (v vector-3-t)
  (d dual-quaternion-t))
(defun tf-qv2duqu (q v &optional (d (make-dual-quaternion)))
  "Convert unit quaternion and translation vector to dual quaternion"
  (aa-tf-qv2duqu q v d)
  d)

(defcfun aa-tf-duqu2qv :void
  (d dual-quaternion-t)
  (q quaternion-t)
  (v vector-3-t))
(defun tf-duqu2qv (d &optional
                   (q (make-quaternion))
                   (v (make-matrix 3 1)))
  "Convert dual quaternion to unit quaternion and translation vector"
  (aa-tf-duqu2qv d q v)
  (values q v))


(defcfun aa-tf-xxyz2duqu :void
  (x-angle :double)
  (x :double)
  (y :double)
  (z :double)
  (s dual-quaternion-t))
(defun tf-xxyz2duqu (x-angle x y z &optional (s (make-dual-quaternion)))
  "x-angle and vector to dual quaternion"
  (aa-tf-xxyz2duqu x-angle x y z s)
  s)


(defcfun aa-tf-yxyz2duqu :void
  (y-angle :double)
  (x :double)
  (y :double)
  (z :double)
  (s dual-quaternion-t))
(defun tf-yxyz2duqu (y-angle x y z &optional (s (make-dual-quaternion)))
  "y-angle and vector to dual quaternion"
  (aa-tf-yxyz2duqu y-angle x y z s)
  s)

(defcfun aa-tf-zxyz2duqu :void
  (z-angle :double)
  (x :double)
  (y :double)
  (z :double)
  (s dual-quaternion-t))
(defun tf-zxyz2duqu (z-angle x y z &optional (s (make-dual-quaternion)))
  "z-angle and vector to dual quaternion"
  (aa-tf-zxyz2duqu z-angle x y z s)
  s)


(defun tf-xangle2duqu (theta &optional (s (make-dual-quaternion)))
  "x-angle to dual quaternion with zero translation"
  (check-type s dual-quaternion)
  (let ((r (make-array 4 :element-type 'double-float)))
    (declare (dynamic-extent r))
    (tf-qv2duqu (tf-xangle2quat theta r)
                +tf-vec-3-ident+
                s)))

(defun tf-yangle2duqu (theta &optional (s (make-dual-quaternion)))
  "y-angle to dual quaternion with zero translation"
  (check-type s dual-quaternion)
  (let ((r (make-array 4 :element-type 'double-float)))
    (declare (dynamic-extent r))
    (tf-qv2duqu (tf-yangle2quat theta r)
                +tf-vec-3-ident+
                s)))

(defun tf-zangle2duqu (theta &optional (s (make-dual-quaternion)))
  "z-angle to dual quaternion with zero translation"
  (check-type s dual-quaternion)
  (let ((r (make-array 4 :element-type 'double-float)))
    (declare (dynamic-extent r))
    (tf-qv2duqu (tf-zangle2quat theta r)
                +tf-vec-3-ident+
                s)))

(defcfun aa-tf-duqu-conj :void
  (x dual-quaternion-t)
  (y dual-quaternion-t))
(defun tf-duqu-conj (x &optional (y (make-dual-quaternion)))
  "Dual quaternion conjugate"
  (aa-tf-duqu-conj x y)
  y)

(def-dq2 (aa-tf-duqu-inv tf-duqu-inv) "Dual quaternion inverse")
(def-dq2 (aa-tf-duqu-ln tf-duqu-ln) "Dual quaternion natural logarithm")
(def-dq2 (aa-tf-duqu-exp tf-duqu-exp) "Dual quaternion exponential")

(def-dq3 (aa-tf-duqu-mul tf-duqu-mul) "Dual quaternion multiply: c = a*b")
(def-dq3 (aa-tf-duqu-add tf-duqu-add) "Dual quaternion add: c = a+b")
(def-dq3 (aa-tf-duqu-sub tf-duqu-sub) "Dual quaternion subtract: c = a-b")
(def-dq3 (aa-tf-duqu-cmul tf-duqu-cmul) "Dual quaternion multiply: c = conj(a)*b")
(def-dq3 (aa-tf-duqu-mulc tf-duqu-mulc) "Dual quaternion multiply: c = a*conj(b)")


(defcfun aa-tf-duqu-normalize :void
  (y dual-quaternion-t))
(defun tf-duqu-normalize (x &optional (y (make-dual-quaternion)))
  "Dual quaternion normalization"
  (matrix-copy x y)
  (aa-tf-duqu-normalize y)
  y)

;;; quaternion-translation
(defcfun aa-tf-qv-chain :void
  (q0 quaternion-t)
  (v0 vector-3-t)
  (q1 quaternion-t)
  (v1 vector-3-t)
  (q2 quaternion-t)
  (v2 vector-3-t))


(defcfun aa-tf-tf-qv :void
  (q quaternion-t)
  (v vector-3-t)
  (p0 vector-3-t)
  (p1 vector-3-t))

(defun tf-duqu2qutr (S &optional (E (make-quaternion-translation)))
  (tf-duqu2qv s
              (quaternion-translation-quaternion e)
              (quaternion-translation-translation e))
  e)

(defun tf-qutr2duqu (e &optional (s (make-dual-quaternion)))
  (tf-qv2duqu (quaternion-translation-quaternion e)
              (quaternion-translation-translation e)
              s))

(defun tf-qutr-mul (e0 e1 &optional (e2 (make-quaternion-translation)))
  (aa-tf-qv-chain (quaternion-translation-quaternion e0)
                  (quaternion-translation-translation e0)
                  (quaternion-translation-quaternion e1)
                  (quaternion-translation-translation e1)
                  (quaternion-translation-quaternion e2)
                  (quaternion-translation-translation e2))
  e2)

(defcfun aa-tf-qv-conj :void
  (q quaternion-t)
  (v vector-3-t)
  (qc quaternion-t)
  (vc vector-3-t))

;;; Euler
(defcfun aa-tf-eulerzyx2quat :void
  (e1 :double)
  (e2 :double)
  (e3 :double)
  (r quaternion-t))
(defun tf-eulerzyx2quat (e1 e2 e3 &optional (r (make-quaternion)))
  (aa-tf-eulerzyx2quat e1 e2 e3 r)
  r)

(defcfun aa-tf-quat2eulerzyx :void
  (q quaternion-t)
  (e euler-zyx-t))
(defun tf-quat2eulerzyx (q &optional (e (make-euler-zyx)))
  (aa-tf-quat2eulerzyx q e)
  e)

;;; Look
(defcfun aa-tf-qv-mzlook :void
  (eye vector-3-t)
  (target vector-3-t)
  (up vector-3-t)
  (q quaternion-t)
  (v vector-3-t))

(defun tf-mzlook (&key eye target up
                    (tf (make-quaternion-translation)))
  (aa-tf-qv-mzlook eye target up
                   (quaternion-translation-quaternion tf)
                   (quaternion-translation-translation tf))
  tf)


;;; Conv

(defcfun aa-tf-tfmat2qv :void
  (m transformation-matrix-t)
  (q quaternion-t)
  (v vector-3-t))

(defcfun aa-tf-qv2tfmat :void
  (q quaternion-t)
  (v vector-3-t)
  (m transformation-matrix-t))

(defcfun aa-tf-tfmat2duqu :void
  (m transformation-matrix-t)
  (dq dual-quaternion-t))

(defcfun aa-tf-duqu2tfmat :void
  (dq dual-quaternion-t)
  (m transformation-matrix-t))

;; (defmacro def-dq2 ((c-fun lisp-fun) doc-string)
;;   `(progn (defcfun ,c-fun :void
;;             (x dual-quaternion-t)
;;             (y dual-quaternion-t))
;;           (defun ,lisp-fun (x &optional (y (make-dual-quaternion)))
;;             ,doc-string
;;             (,c-fun x y)
;;             y)))
