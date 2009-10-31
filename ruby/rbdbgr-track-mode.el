;;; rbdbgr-track-mode.el --- Ruby "rbdbgr" Debugger tracking a comint
;;; or eshell buffer.

(eval-when-compile (require 'cl))

(defun rbdbgr-directory ()
  "The directory of this file, or nil."
  (let ((file-name (or load-file-name
                       (symbol-file 'rbdbgr-track-mode))))
    (if file-name
        (file-name-directory file-name)
      nil)))

(setq load-path (cons nil 
		      (cons (format "%s.." (rbdbgr-directory))
				    (cons (rbdbgr-directory) load-path))))
(require 'dbgr-track-mode)
(require 'rbdbgr-core)
(setq load-path (cdddr load-path))


(defun rbdbgr-track-mode-body()
  "Called when entering or leaving rbdbgr-track-mode"
  (dbgr-track-set-debugger "rbdbgr")
  (if rbdbgr-track-mode
      (progn 
	(dbgr-track-mode 't)
	(run-mode-hooks 'rbdbgr-track-mode-hook))
    (progn 
      (dbgr-track-mode nil)
    )))

(defvar rbdbgr-track-mode nil
  "Non-nil if using rbdbgr-track mode as a minor mode of some other mode.
Use the command `rbdbgr-track-mode' to toggle or set this variable.")

(defvar rbdbgr-track-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map [C-c !]	'rbdbgr-goto-dollarbang-traceback-line)
    (define-key map [C-c e]	'rbdbgr-goto-traceback-line)
    map)
  "Keymap used in `rbdbgr-track-mode'.")

(define-minor-mode rbdbgr-track-mode
  "Minor mode for tracking ruby debugging inside a process shell."
  :init-value nil
  ;; :lighter " rbdbgr"   ;; mode-line indicator from dbgr-track is sufficient.
  ;; The minor mode bindings.
  :global nil
  :group 'rbdbgr
  :keymap rbdbgr-track-mode-map
  (rbdbgr-track-mode-body)
)

;; -------------------------------------------------------------------
;; The end.
;;

(provide 'rbdbgr-track-mode)

;;; Local variables:
;;; eval:(put 'rbdbg-debug-enter 'lisp-indent-hook 1)
;;; End:

;;; rbdbgr-track.el ends here
