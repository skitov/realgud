;;; Copyright (C) 2010 Rocky Bernstein <rocky@gnu.org>
;;; Common Ruby regular expressions and things
(eval-when-compile (require 'cl))

(require 'load-relative)
(require-relative-list '("../common/regexp" "../common/loc" "../common/track") 
		       "dbgr-")


(defconst dbgr-ruby-backtrace-loc-pat
  (make-dbgr-loc-pat
   :regexp "^[ \t]+from \\([^:]+\\):\\([0-9]+\\)\\(?: in `.*'\\)?"
   :file-group 1
   :line-group 2)
  "A dbgr-loc-pat struct that describes a Ruby backtrace (or
traceback) line."  )

(defconst dbgr-ruby-dollar-bang
      (make-dbgr-loc-pat
       :regexp "^[ \t]*[[]?\\(.+\\):\\([0-9]+\\):in `.*'"
       :file-group 1
       :line-group 2)
  "A dbgr-loc-pat that struct that describes a Ruby $! string."
)

;; FIXME: there is probably a less redundant way to do the following
;; FNS. 
(defun dbgr-ruby-goto-backtrace-line (pt)
  "Display the location mentioned by the Ruby backtrace line
described by PT."
  (interactive "d")
  (dbgr-goto-line-for-pt pt "backtrace"))

(defun dbgr-ruby-goto-dollarbang-backtrace-line (pt)
  "Display the location mentioned by a Ruby $! backtrace line
described by PT."
  (interactive "d")
  (dbgr-goto-line-for-pt pt "dollar-bang"))

(defun dbgr-ruby-populate-command-keys (&optional map)
  "Bind the debugger function key layout used by many debuggers.

\\{dbgr-example-map-standard}"
  (define-key map (kbd "C-c !!") 'dbgr-ruby-goto-dollarbang-backtrace-line)
  (define-key map (kbd "C-c !b") 'dbgr-ruby-goto-backtrace-line)
  )



(provide-me "dbgr-lang-")