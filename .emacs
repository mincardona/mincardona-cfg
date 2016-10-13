(require 'package)
;; Add the original Emacs Lisp Package Archive
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
;; Add the user-contributed repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;
;; whitespace stuff
;;

(defvar my-indent 4 "My indentation offset.")
(setq tab-stop-list (number-sequence my-indent 120 my-indent))
(setq-default indent-tabs-mode nil)
(setq-default tab-always-indent nil)
(setq-default tab-width my-indent)
(global-set-key (kbd "TAB") 'tab-to-tab-stop)
(defvaralias 'c-basic-offset 'my-indent)
(defvaralias 'cperl-indent-level 'my-indent)
;(setq-default c-hungry-delete-key t)

(electric-indent-mode -1)
(setq-default electric-indent-inhibit t)

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

; TODO: smart backspace
(defun smart-del ()
    "Deletes whitespace until tab stop, or just the last character."
    (interactive)
    (if (bolp)
        (delete-backward-char)
    ;else
        (if (= 0 (% (current-column) my-indent))
            (setq last-tabstop (- (current-column) 4))
        ;else
            (setq last-tabstop (/ (current-column) 4))
        )
        (string-match "[ \t]*" (thing-at-point 'line t) last-tabstop)
        (if (>= (match-end 0) (current-column))
            (delete-backward-char (- (match-end 0) last-tabstop))
        ; else
            (delete-backward-char)
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
