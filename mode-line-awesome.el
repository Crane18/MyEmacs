;; Use align-left icon for `auto-fill-mode'.
(eval-after-load 'diminish-autoloads
  '(eval-after-load 'simple
     '(diminish 'auto-fill-function (concat " " (char-to-string #xF036)))))

;; Use thumbs-up / thumbs-down for flymake status.
;; We need to reimplement `flymake-report-status' to make this happen.
(eval-after-load 'flymake
  '(defun flymake-report-status (e-w &optional status)
     "Show status in mode line."
     (when e-w
       (setq flymake-mode-line-e-w e-w))
     (when status
       (setq flymake-mode-line-status status))
     (let* ((mode-line " "))
       (if (> (length flymake-mode-line-e-w) 0)
           (setq mode-line (concat mode-line (char-to-string #xF165) flymake-mode-line-e-w))
         (setq mode-line (concat mode-line (char-to-string #xF164))))
       (setq mode-line (concat mode-line flymake-mode-line-status))
       (setq flymake-mode-line mode-line)
       (force-mode-line-update))))
;; Use the tags icon for `gtags-mode'.
(add-hook 'gtags-mode-hook '(lambda ()
                              (diminish 'gtags-mode (concat " " (char-to-string #xF02C)))))
(provide 'mode-line-awesome)