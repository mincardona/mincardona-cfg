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

(defvar my-offset 4 "My indentation offset.")
(setq tab-stop-list (number-sequence my-offset 120 my-offset))
(setq-default indent-tabs-mode nil)
(setq-default tab-always-indent nil)
(setq-default tab-width my-offset)
(global-set-key (kbd "TAB") 'tab-to-tab-stop)

(electric-indent-mode -1)
;; is this even effective?
(setq-default electric-indent-inhibit t)

(global-set-key (kbd "RET") 'newline-and-indent)

; causes issues
;(setq-default indent-line-function 'tab-to-tab-stop)

; smart backspace indentation
(global-set-key (kbd "DEL") 'backspace-whitespace-to-tab-stop)
(defun backspace-whitespace-to-tab-stop ()
  "Delete whitespace backwards to the next tab-stop, otherwise delete one character."
  (interactive)
  (if (or indent-tabs-mode
          (region-active-p)
          (save-excursion
            (> (point) (progn (back-to-indentation)
                              (point)))))
      (call-interactively 'backward-delete-char-untabify)
    (let ((movement (% (current-column) my-offset))
          (p (point)))
      (when (= movement 0) (setq movement my-offset))
      ;; Account for edge case near beginning of buffer
      (setq movement (min (- p 1) movement))
      (save-match-data
        (if (string-match "[^\t ]*\\([\t ]+\\)$" (buffer-substring-no-properties (- p movement) p))
            (backward-delete-char (- (match-end 1) (match-beginning 1)))
          (call-interactively 'backward-delete-char))))))

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
