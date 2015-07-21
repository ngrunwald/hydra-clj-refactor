;;; hydra-clj-refactor.el --- clj-refactor help implemented in Hydra

;; Copyright (C) 2015  Free Software Foundation, Inc.

;; Author: Nils Grunwald

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; An hydra to help me learn all the wonderful goodies in clj-refactor.el

;;; Code:
(require 'hydra)
(require 'clj-refactor)

(defhydra hydra-clj-refactor-let (:hint nil :color blue)
  "
_i_: Introduce let binding
_e_: Find the closest let and move it up one level in the syntax tree
_m_: Move current form to the closest let
_r_: Remove the containing let form, inlining any bound variables
_d_: Destructure top-level symbol at point into keys

Use upper-case letter to get more info.
"
  ("i" cljr-introduce-let)
  ("I" (cljr-describe-refactoring "cljr-introduce-let"))
  ("e" cljr-expand-let :color red)
  ("E" (cljr-describe-refactoring "cljr-expand-let"))
  ("m" cljr-move-to-let)
  ("M" (cljr-describe-refactoring "cljr-move-to-let"))
  ("r" cljr-remove-let)
  ("R" (cljr-describe-refactoring "cljr-remove-let"))
  ("d" cljr-destructure-keys)
  ("D" (cljr-describe-refactoring "cljr-destructure-keys"))
  ("b" hydra-clj-refactor/body "back")
  ("q" nil "cancel"))

(defhydra hydra-clj-refactor-thread (:hint nil :color blue)
  "
_t_: Thread form at point into the surrounding thread
_f_: Rewrite the form following point to use ->     _l_: Same with ->>
_u_: Eliminate one step of the threading macro      _a_: Eliminate the threading completely

Use upper-case letter to get more info.
"
  ("t" cljr-thread)
  ("T" (cljr-describe-refactoring "cljr-thread"))
  ("f" cljr-thread-first-all)
  ("F" (cljr-describe-refactoring "cljr-thread-first-all"))
  ("l" cljr-thread-last-all)
  ("L" (cljr-describe-refactoring "cljr-thread-last-all"))
  ("u" cljr-unwind)
  ("F" (cljr-describe-refactoring "cljr-unwind"))
  ("a" cljr-unwind-all)
  ("A" (cljr-describe-refactoring "cljr-unwind-all"))
  ("b" hydra-clj-refactor/body "back")
  ("q" nil "cancel"))

(defhydra hydra-clj-refactor-symbol (:hint nil :color blue)
  "
_f_: Find usages of the symbol at point
_i_: Inline all occurrences of the symbol at point
_r_: Rename all occurrences of the symbol at point
_p_: Cycle privacy of defn and def

Use upper-case letter to get more info.
"
  ("f" cljr-find-usages)
  ("F" (cljr-describe-refactoring "cljr-find-usages"))
  ("i" cljr-inline-symbol)
  ("I" (cljr-describe-refactoring "cljr-inline-symbol"))
  ("r" cljr-rename-symbol)
  ("R" (cljr-describe-refactoring "cljr-rename-symbol"))
  ("p" cljr-cycle-privacy :color red)
  ("P" (cljr-describe-refactoring "cljr-cycle-privacy"))
  ("b" hydra-clj-refactor/body "back")
  ("q" nil "cancel"))

(defhydra hydra-clj-refactor-fn (:hint nil :color blue)
  "
_e_: Extract the form at point, or the nearest enclosing form, into a toplevel defn
_p_: Promote function literal to anonymous function
_s_: Create function stub from example usage according to signature

Use upper-case letter to get more info.
"
  ("e" cljr-extract-function)
  ("E" (cljr-describe-refactoring "cljr-extract-function"))
  ("p" cljr-promote-function)
  ("P" (cljr-describe-refactoring "cljr-promote-function"))
  ("s" cljr-create-fn-from-example)
  ("S" (cljr-describe-refactoring "cljr-create-fn-from-example"))
  ("b" hydra-clj-refactor/body "back")
  ("q" nil "cancel"))

(defhydra hydra-clj-refactor-ns (:hint nil :color blue)
  "
_s_: try to resolve the symbol at point and require or import the missing symbol
_d_: Add a declare for the current top-level form
_r_: Add require to ns declaration         _i_: Same with import
_c_: Lots of cleaning on the ns form       _p_: Remove debug fns invocations

Use upper-case letter to get more info.
"
  ("s" cljr-add-missing-libspec)
  ("S" (cljr-describe-refactoring "cljr-add-missing-libspec"))
  ("r" cljr-add-require-to-ns)
  ("R" (cljr-describe-refactoring "cljr-add-require-to-ns"))
  ("i" cljr-add-import-to-ns)
  ("I" (cljr-describe-refactoring "cljr-add-import-to-ns"))
  ("d" cljr-add-declaration)
  ("D" (cljr-describe-refactoring "cljr-add-declaration"))
  ("c" cljr-clean-ns)
  ("C" (cljr-describe-refactoring "cljr-clean-ns"))
  ("p" cljr-remove-debug-fns)
  ("P" (cljr-describe-refactoring "cljr-remove-debug-fns"))
  ("b" hydra-clj-refactor/body "back")
  ("q" nil "cancel"))

(defhydra hydra-clj-refactor-misc (:hint nil :color blue)
  "
_c_: Cycle the collection at point between list, map, vector and set literals
_i_: Cycle between if and if-not
_a_: Add stubs for the methods of the interface or protocol at point

Use upper-case letter to get more info.
"
  ("c" cljr-cycle-coll :color red)
  ("C" (cljr-describe-refactoring "cljr-cycle-coll"))
  ("i" cljr-cycle-if :color red)
  ("I" (cljr-describe-refactoring "cljr-cycle-if"))
  ("a" cljr-add-stubs)
  ("A" (cljr-describe-refactoring "cljr-add-stubs"))
  ("b" hydra-clj-refactor/body "back")
  ("q" nil "cancel"))

(defhydra hydra-clj-refactor-project (:hint nil :color blue)
  "
_c_: Some clean up on all clj files in a project in bulk
_a_: Add project dependency and hot reload it in the REPL
_m_: Move one or more forms to another namespace and :refer any functions
_r_: Rename a file or directory updating ns declarations project-wide
_u_: Prompts to update dependencies in project.clj

Use upper-case letter to get more info.
"
  ("c" cljr-project-clean)
  ("C" (cljr-describe-refactoring "cljr-project-clean"))
  ("a" cljr-add-project-dependency)
  ("A" (cljr-describe-refactoring "cljr-add-project-dependency"))
  ("m" cljr-move-form)
  ("M" (cljr-describe-refactoring "cljr-move-form"))
  ("r" cljr-rename-file-or-dir)
  ("R" (cljr-describe-refactoring "cljr-rename-file-or-dir"))
  ("u" cljr-update-project-dependencies)
  ("U" (cljr-describe-refactoring "cljr-update-project-dependencies"))
  ("b" hydra-clj-refactor/body "back")
  ("q" nil "cancel"))

(defhydra hydra-clj-refactor (:hint nil :color blue)
  "
_l_: let refactoring         _f_: fn refactoring
_>_: threading refactoring   _n_: ns refactoring
_s_: symbol refactoring      _m_: misc refactoring
_p_: project refactoring

_?_: Describe refactoring
"
  ("l" hydra-clj-refactor-let/body)
  (">" hydra-clj-refactor-thread/body)
  ("s" hydra-clj-refactor-symbol/body)
  ("f" hydra-clj-refactor-fn/body)
  ("n" hydra-clj-refactor-ns/body)
  ("m" hydra-clj-refactor-misc/body)
  ("p" hydra-clj-refactor-project/body)
  ("?" cljr-describe-refactoring)
  ("q" nil "cancel"))


(define-key clojure-mode-map (kbd "C-c C-v") 'hydra-clj-refactor/body)

(provide 'hydra-clj-refactor)

;;; hydra-clj-refactor.el ends here
