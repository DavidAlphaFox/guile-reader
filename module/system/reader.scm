;;; reader.scm  --  A framework for building Scheme-like readers.
;;;
;;; Copyright 2005  Ludovic Court�s <ludovic.courtes@laas.fr>
;;;
;;;
;;; This program is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 2 of the License, or
;;; (at your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program; if not, write to the Free Software
;;; Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,
;;; USA.

(define-module (system reader)
   #:export (make-reader make-token-reader

	     ;; helpers
	     standard-token-reader default-reader

	     ;; accessors
	     token-reader-procedure token-reader-specification
             token-reader-escape?))

;;; Author:  Ludovic Court�s
;;;
;;; Commentary:
;;;
;;; This module provides a simple framework for building readers.  Readers
;;; are procedures that work like Scheme's @code{read} procedure.  However,
;;; using this framework, one may construct readers that integrate extensions
;;; to the standard R5RS syntax, or even readers that understand syntaxes
;;; significantly different from that.  Re-using pieces of a standard Scheme
;;; reader is made easy (via the @code{standard-token-reader} procedure),
;;; which means that the user does not need to rewrite a full reader.
;;;
;;; Code:


(dynamic-call "scm_reader_init_bindings"
              (dynamic-link "libguile-reader.so"))


;;; reader.scm ends here
