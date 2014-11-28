;; -*- coding: utf-8 -*-
(setq emacs-load-start-time (current-time))
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(setq *macbook-pro-support-enabled* t)
(setq *is-a-mac* (eq system-type 'darwin))
(setq *is-carbon-emacs* (and *is-a-mac* (eq window-system 'mac)))
(setq *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))
(setq *win32* (eq system-type 'windows-nt) )
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
(setq *linux-x* (and window-system *linux*) )
(setq *xemacs* (featurep 'xemacs) )
(setq *emacs23* (and (not *xemacs*) (or (>= emacs-major-version 23))) )
(setq *emacs24* (and (not *xemacs*) (or (>= emacs-major-version 24))) )

;----------------------------------------------------------------------------
; Functions (load all files in defuns-dir)
; Copied from https://github.com/magnars/.emacs.d/blob/master/init.el
;----------------------------------------------------------------------------
(setq defuns-dir (expand-file-name "~/.emacs.d/defuns"))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
      (load file)))
;----------------------------------------------------------------------------
; Load configs for specific features and modes
;----------------------------------------------------------------------------
(require 'init-modeline)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require 'cl-lib)
(require 'init-compat)
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el

;; win32 auto configuration, assuming that cygwin is installed at "c:/cygwin"
(condition-case nil
    (when *win32*
      (setq cygwin-mount-cygwin-bin-directory "c:/cygwin/bin")
      (require 'setup-cygwin)
      ;; better to set HOME env in GUI
      ;; (setenv "HOME" "c:/cygwin/home/someuser")
      )
  (error
   (message "setup-cygwin failed, continue anyway")
   ))

(require 'init-elpa)
(require 'init-exec-path) ;; Set up $PATH
(require 'init-frame-hooks)
;; any file use flyspell should be initialized after init-spelling.el
;; actually, I don't know which major-mode use flyspell.
(require 'init-spelling)
(require 'init-xterm)
(require 'init-osx-keys)
(require 'init-gui-frames)
(require 'init-maxframe)
(require 'init-proxies)
(require 'init-dired)
(require 'init-isearch)
(require 'init-uniquify)
(require 'init-ibuffer)
(require 'init-flymake)
(require 'init-artbollocks-mode)
(require 'init-recentf)
(require 'init-ido)
(require 'init-smex)
(if *emacs24* (require 'init-helm))
(require 'init-hippie-expand)
(require 'init-windows)
(require 'init-sessions)
(require 'init-fonts)
(require 'init-git)
(require 'init-crontab)
(require 'init-textile)
(require 'init-markdown)
(require 'init-csv)
(require 'init-erlang)
(require 'init-javascript)
(require 'init-sh)
(when *emacs24*
  (require 'init-org)
  (require 'init-org-mime))
(require 'init-css)
(require 'init-haml)
(require 'init-python-mode)
(require 'init-haskell)
(require 'init-ruby-mode)
(require 'init-lisp)
(require 'init-elisp)
(require 'init-yasnippet)
;; Use bookmark instead
(require 'init-zencoding-mode)
(require 'init-yari)
(require 'init-cc-mode)
(require 'init-gud)
(require 'init-semantic)
(require 'init-cmake-mode)
(require 'init-csharp-mode)
(require 'init-linum-mode)
(require 'init-emacs-w3m)
(require 'init-eim)
(require 'init-which-func)
(require 'init-keyfreq)
;; (require 'init-gist)
(require 'init-emacspeak)
(require 'init-pomodoro)
(require 'init-moz)
(require 'init-gtags)
;; use evil mode (vi key binding)
;;(require 'init-evil)
(require 'init-misc)
(require 'init-ctags)
(require 'init-ace-jump-mode)
(require 'init-bbdb)
(require 'init-gnus)
;; itune cannot play flac, so I use mplayer+emms instead (updated, use mpd!)
(require 'init-emms)
(require 'init-lua-mode)
(require 'init-doxygen)
(require 'init-workgroups2)
(require 'init-move-window-buffer)
(require 'init-term-mode)
(require 'init-web-mode)
(require 'init-sr-speedbar)
(require 'init-smartparens)
(require 'init-slime)
(when *emacs24* (require 'init-company))
(require 'init-stripe-buffer)
(require 'init-elnode)
(require 'mode-line-awesome)
(require 'rainbow-delimiters)
;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(if (file-readable-p (expand-file-name "~/.custom.el"))
     (load-file (expand-file-name "~/.custom.el")))

;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-local" containing personal settings
;;----------------------------------------------------------------------------
(require 'init-local nil t)


;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
;(require 'init-locales) ;does not work in cygwin


(when (require 'time-date nil t)
   (message "Emacs startup time: %d seconds."
    (time-to-seconds (time-since emacs-load-start-time)))
   )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.bmk")
 '(safe-local-variable-values (quote ((emacs-lisp-docstring-fill-column . 75) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby"))))
 '(session-use-package t nil (session)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "spring green"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "orange red"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "chartreuse"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "cyan"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "dark violet"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "dark khaki"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "rosy brown"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "magenta"))))
 '(window-numbering-face ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold))) t))
;;; Local Variables:
;;; no-byte-compile: t
;;; End:
(put 'erase-buffer 'disabled nil
     )
;;给所有的编程语言设置rainbow-mode
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;;该函数用于全屏，状态值为2说明全屏后可以还原
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
(global-set-key [f11] 'my-fullscreen)

;;android mode
;;(require 'android-mode)
;;(setq android-mode-sdk-dir "~/androidsdk")

(defun fullscreen ()
(interactive)
(x-send-client-message nil 0 nil “_NET_WM_STATE” 32
‘(2 “_NET_WM_STATE_FULLSCREEN” 0)))


;;used to comment or uncomment
(global-set-key [?\C-c ?\C-/] 'comment-or-uncomment-region)
(defun my-comment-or-uncomment-region (beg end &optional arg)
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end) nil)
                 (list (line-beginning-position)
                       (line-beginning-position 2))))
  (comment-or-uncomment-region beg end arg)
)
(global-set-key [remap comment-or-uncomment-region] 'my-comment-or-uncomment-region)
(defun my-comment-or-uncomment-region (beg end &optional arg)
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end) nil)
                 (list (line-beginning-position)
                       (line-beginning-position 2))))
  (comment-or-uncomment-region beg end arg)
)
(global-set-key [remap comment-or-uncomment-region] 'my-comment-or-uncomment-region)

;; To use company-mode in all buffers,
;; (add-hook 'after-init-hook 'global-company-mode)

;; Because Java for Android uses Java 1.5 or above, it will be full of annotations such as “@Override”.
;;The C/Java modes for emacs don’t appear to have been updated to support this syntax so indentation won’t be quite right.
;;To fix this, you need a minor mode called java-mode-indent-annotations.el <- click on the Download
;;link on that page and save the file as ~/.emacs.d/java-mode-indent-annotations.el

;;(setq android-mode-sdk-dir "~/androidsdk/")
;;(require 'android-mode)
;;(require 'java-mode-indent-annotations)

(global-set-key (kbd "M-5") 'iwb) ;;格式化整个文件
(defun iwb ()
	"indent whole buffer"
	(interactive)
	(delete-trailing-whitespace)
	(indent-region (point-min) (point-max) nil))
(setq java-mode-hook
    (function (lambda()
       (java-mode-indent-annotations-setup))))

(add-hook 'c-mode-hook 'linux-c-mode)	;;C/C++
(add-hook 'c++-mode-hook 'linux-cpp-mode)
(defun linux-c-mode()
  (define-key c-mode-map [return] 'newline-and-indent)
  (setq c-basic-offset 4)
  (which-function-mode)
)
(defun linux-cpp-mode()
  (define-key c++-mode-map [return] 'newline-and-indent)
  (interactive)
  (setq c-basic-offset 4)
  (which-function-mode)
)
;;delete the whole line using C-k wherever the cursor is!!!
(defun my-kill-whole-line()
  (interactive) ;;这个是命令必须要调用一个函数，表示我是一个命令，而不仅仅是普通的函数
  (beginning-of-line)  ;; 跳到行首，，默认C-a 绑定的函数
  (kill-line)  ;;这个是删除光标到行末之间内容的函数，默认绑定为C-k
  )

(global-set-key (kbd "C-k") 'my-kill-whole-line)  ;;这个将my-kill-whole-line重新绑定到C-k上

;;; **************************************************************************
;;; ***** built-in functions
;;; **************************************************************************
(defun eshell/clear () ;;clear可换其他名称
  "Clears the shell buffer ala Unix's clear or DOS' cls"
  (interactive)
  ;; the shell prompts are read-only, so clear that for the duration
  (let ((inhibit-read-only t))
	;; simply delete the region
	(delete-region (point-min) (point-max))))

;; clojure-mode
(global-set-key [f9] 'cider-jack-in)
;; (add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
(add-hook 'clojure-mode-hook 'subword-mode)
(add-hook 'clojure-mode-hook 'company-mode)
(add-hook 'clojure-mode-hook 'smartparens-strict-mode)
;; (add-hook 'cojure-mode-hook 'rainbow-delimiters-mode)

;; Auto complete
;; (require 'auto-complete-config)
;; ;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;; (setq ac-delay 0.0)
;; ;(setq ac-use-quick-help t)
;; (setq ac-quick-help-delay 0.5)
;; ;(setq ac-use-fuzzy 1)
;; ;(setq ac-auto-start 1)
;; ;(setq ac-auto-show-menu 1)
;; (ac-config-default)
;; (setq ac-use-menu-map t)
;; ;; Default settings
;; (define-key ac-menu-map "\C-n" 'ac-next)
;; (define-key ac-menu-map "\C-p" 'ac-previous)


;; cider-mode
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-mode-hook 'company-mode)
(add-hook 'cider-mode-hook 'smartparens-strict-mode)
(add-hook 'cider-mode-hook 'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook 'company-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook 'smartparens-mode)
;; (defun set-auto-complete-as-completion-at-point-function ()
;;   (setq completion-at-point-functions '(auto-complete)))
;; (add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
;; (add-hook 'cider-repl-mode-hook 'set-auto-complete-as-completion-at-point-function)
;; (add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)

;; (defun remove-dos-eol ()
;;   "Do not show ^M in files containing mixed UNIX and DOS line endings."
;;   (interactive)
;;   (setq buffer-display-table (make-display-table))
;;   (aset buffer-display-table ?\^M []))

;; (add-hook 'cider-repl-mode-hook 'remove-dos-eol)

;; Change the result prefix for REPL evaluation (by default there's no prefix):
(setq cider-interactive-eval-result-prefix ";; => ")
;; Change the result prefix for REPL evaluation (by default there's no prefix):
(setq cider-repl-result-prefix ";= ")
;; (setq cider-repl-tab-command 'indent-for-tab-command)
;; To prefer local resources to remote (tramp) ones when both are available:
(setq cider-prefer-local-resources t)
;; Prevent the auto-display of the REPL buffer in a separate window after connection is established:
;; (setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-show-error-buffer nil)
(setq cider-auto-select-error-buffer nil)
(setq nrepl-buffer-name-show-port t)
;; (setq cider-stacktrace-fill-column 80)
;; (setq nrepl-buffer-name-show-port t)
;; Make C-c C-z switch to the CIDER REPL buffer in the current window:
;; (setq cider-repl-display-in-current-window t)


;;fill-column-indicator
;; (require 'fill-column-indicator)
;; (setq-default fci-rule-column 80)
;; (setq fci-handle-truncate-lines nil)
;; (setq fci-rule-width 1)
;; (setq fci-rule-color "darkblue")
;; (setq fci-rule-use-dashes 0.75)
;; (define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
;; ;; (global-fci-mode 1)
;; (defun auto-fci-mode (&optional unused)
;;     (if (> (window-width) fci-rule-column)
;;         (fci-mode 1)
;;       (fci-mode 0))
;;     )
;; (add-hook 'after-change-major-mode-hook 'auto-fci-mode)
;; (add-hook 'window-configuration-change-hook 'auto-fci-mode)
;; (add-hook 'clojure-mode-hook 'auto-fci-mode)
;; (add-hook 'cider-mode-hook 'auto-fci-mode)
