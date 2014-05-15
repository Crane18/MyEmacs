;;; evil-matchit-org.el ---org (ruby/lua) plugin of evil-matchit

;; Copyright (C) 2014  Chen Bin <chenbin.sh@gmail.com>

;; Author: Chen Bin <chenbin.sh@gmail.com>

;; This file is not part of GNU Emacs.

;;; License:

;; This file is part of evil-matchit
;;
;; evil-matchit is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as published
;; by the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; evil-matchit is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.


;;; Code:

;; OPTIONAL, you don't need SDK to write a plugin for evil-matchit
;; but SDK don make you write less code, isn't it?
;; All you need to do is just define the match-tags for SDK algorithm to lookup.
(require 'evil-matchit-sdk)

(defvar evilmi-org-extract-keyword-howtos
  '(("^[ \t]*#\\+\\([a-zA-Z_]+\\).*$" 1)
    )
  "The list of HOWTO on extracting keyword from current line.
Each howto is actually a pair. The first element of pair is the regular
expression to match the current line. The second is the index of sub-matches
to extract the keyword which starts from one. The sub-match is the match defined
between '\\(' and '\\)' in regular expression.
"
  )
;; ruby/bash/lua/vimrc
(defvar evilmi-org-match-tags
  '((("begin_src" "BEGIN_SRC") () ( "end_src" "END_SRC"))
    (("begin_example" "BEGIN_EXAMPLE") () ( "end_example" "END_EXAMPLE"))
    (("begin_html" "BEGIN_HTML") () ( "end_html" "END_HTML"))
    )
  "The table we look up match tags. This is a three column table.
The first column contains the open tag(s).
The second column contains the middle tag(s).
The third column contains the closed tags(s).
"
  )

(defun evilmi--get-embedded-language-major-mode ()
  (let ((info (org-edit-src-find-region-and-lang))
        lang
        lang-f)
    (if info
        (progn
          (setq lang (or (cdr (assoc (nth 2 info) org-src-lang-modes))
                         (nth 2 info)))
          (setq lang (if (symbolp lang) (symbol-name lang) lang))
          (setq lang-f (intern (concat lang "-mode")))
          ))
    lang-f))

;;;###autoload
(defun evilmi-org-get-tag ()
  (let (rlt)
    (setq rlt (evilmi-sdk-get-tag evilmi-org-match-tags evilmi-org-extract-keyword-howtos))
    (message "rlt=%s" rlt)

    ;;
    (when (not rlt)
      (let ( )
        )
      )
    rlt
    ))

;;;###autoload
(defun evilmi-org-jump (rlt NUM)
  (let (where-to-jump-in-theory
        jumped
        plugin)
    )
  (message "rlt=%s" rlt)
  (evilmi-sdk-jump rlt NUM evilmi-org-match-tags evilmi-org-extract-keyword-howtos)
  ;; (lang-f
  ;;  (setq plugin (plist-get evilmi-plugins lang-f))
  ;;  (message "plugin=%s" plugin)
  ;;  (if plugin
  ;;      (mapc
  ;;       (lambda (elem)
  ;;         (setq rlt (funcall (nth 0 elem)))
  ;;         (when (and rlt (not jumped))
  ;;           ;; before jump, we may need some operation
  ;;           (if FUNC (funcall FUNC rlt))
  ;;           ;; jump now
  ;;           (setq where-to-jump-in-theory (funcall (nth 1 elem) rlt NUM))
  ;;           ;; jump only once if the jump is successful
  ;;           (setq jumped t)
  ;;           ))
  ;;       plugin
  ;;       ))
  ;;  where-to-jump-in-theory)
  )

(provide 'evil-matchit-org)
