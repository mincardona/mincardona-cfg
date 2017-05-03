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

;;
;; general settings
;;

(setq-default require-final-newline t)
(setq-default delete-trailing-lines nil)
(setq auto-save-default nil)
(setq-default make-backup-files nil)
;(setq-default cursor-type '(bar . 1))
(setq-default cursor-type 'box)
(setq-default blink-cursor-blinks 0)

;; 
;; Minor mode
;; 

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

; Deletes groups of spaces if on a tabstop
(defun smart-del ()
    "Deletes 4 spaces back when on a tabstop, or just the last character."
    (interactive)
    ; if current column is at beginning of line or not on a tab stop
    ; or if the previous character is "\t"
    (if (or (bolp) (/= 0 (% (current-column) my-indent)) 
            (string= (string (char-before)) "\t")
    )
    
    ;then
        (delete-backward-char 1)
    ;else
        ; we are on a non-zero tabstop, compute the previous tabstop
        (setq last-tabstop (- (current-column) my-indent))
        ; if there are only spaces and/or tabs between the cursor and last tabstop
        (if (and (string-match "[ \t]*" (thing-at-point 'line t) last-tabstop) 
                 (>= (match-end 0) (current-column))
            )
        ;then
            ; delete back to the tabstop
            (delete-backward-char (- (current-column) last-tabstop))
        ;else
            ; there are non-whitespace char(s), just delete one
            (delete-backward-char 1)
        )
    )
)

(defvar my-keys-minor-mode-map
    (let ((map (make-sparse-keymap)))
        (define-key map (kbd "RET") 'newline-preserve-indent)
        (define-key map [backspace] 'smart-del)
        (define-key map "\d" 'smart-del)
        (define-key map (kbd "M-/") 'hippie-expand)
        map)
      "my-keys-minor-mode keymap.")
      
(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " my-keys")

(my-keys-minor-mode 1)

(defun my-minor-off-hook ()
    (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minor-off-hook)

(add-hook 'term-mode-hook 'my-minor-off-hook)

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
