(require 'package)
;; Add the original Emacs Lisp Package Archive
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
;; Add the user-contributed repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;
;; whitespace and indentation stuff
;;

(defvar my-indent 4 "My indentation offset.")
(setq tab-stop-list (number-sequence my-indent 120 my-indent))
(setq-default indent-tabs-mode nil)
(setq-default tab-always-indent nil)
(setq-default tab-width my-indent)
(defvaralias 'c-basic-offset 'my-indent)
(defvaralias 'cperl-indent-level 'my-indent)

(electric-indent-mode -1)
(setq-default electric-indent-inhibit t)

(global-set-key (kbd "TAB") 'tab-to-tab-stop)

; Retains indent level on newline
(defun newline-preserve-indent ()
    "Insert a newline after point with the same indentation as the current line."
    (interactive)
    (progn
     (setq srcstr (thing-at-point 'line t))
     (newline)
     (string-match "^[ \t]*" srcstr)
     (insert (substring srcstr 0 (match-end 0)))
    )
)
(global-set-key (kbd "RET") 'newline-preserve-indent)

; Deletes groups of spaces if on a tabstop
(defun smart-del ()
    "Deletes 4 spaces back when on a tabstop, or just the last character."
    (interactive)
    (if (or (bolp) (/= 0 (% (current-column) my-indent)))
        (delete-backward-char 1)
    ;else
        (setq last-tabstop (- (current-column) my-indent))
        (if (and (string-match "[ \t]*" (thing-at-point 'line t) last-tabstop) 
                 (>= (match-end 0) (current-column))
            )
            (delete-backward-char (- (current-column) last-tabstop))
        ; else
            (delete-backward-char 1)
        )
    )
)
(global-set-key [backspace] 'smart-del)

;;
;; general settings
;;

(global-set-key (kbd "M-/") 'hippie-expand)
(setq-default delete-trailing-lines nil)
(setq auto-save-default nil)
(setq-default make-backup-files nil)
;(setq-default cursor-type '(bar . 1))
(setq-default cursor-type 'bar)
(setq-default blink-cursor-blinks 0)

;;
;; lisp system
;;

; Set your lisp system and, optionally, some contribs
(setq-default inferior-lisp "/usr/bin/clisp")
(setq-default inferior-lisp-program "/usr/bin/clisp")
(setq-default slime-contribs '(slime-fancy))
(setq-default slime-lisp-implementations
        '((clisp ("/usr/bin/clisp") ))
    )

;;
;; Emacs custom set
;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
