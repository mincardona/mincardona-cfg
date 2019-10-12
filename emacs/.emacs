; set encoding before anything else
(prefer-coding-system 'utf-8-unix)

; load custom scripts
(add-to-list 'load-path "~/.emacs.d/lisp")

;;
;; General settings
;;

;; require a single blank line at the end of each file
(setq-default require-final-newline t)
(setq-default delete-trailing-lines nil)
;; don't create backup files and clutter
(setq auto-save-default nil)
(setq-default make-backup-files nil)
;; set the cursor type
;(setq-default cursor-type '(bar . 1))
(setq-default cursor-type 'box)
;; cursor blink never times out
(setq-default blink-cursor-blinks 0)
;; add handles to resize windows
(setq-default window-divider-default-places t)
(window-divider-mode +1)
;; add column number (row, column) and buffer size to status bars
(column-number-mode)
(size-indication-mode)
;; buffer boundary indicators
(setq-default indicate-buffer-boundaries '((up . right) (down . right)))
;; mouse wheel scroll speed
(setq-default mouse-wheel-scroll-amount '(3 ((shift) . 10) ((control) . nil)))
(setq-default mouse-wheel-progressive-speed nil)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; move between windows using S-<left>, etc
(when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings))

;;
;; Whitespace and indentation stuff
;;

(setq-default c-default-style "k&r")
(defvar my-indent 4 "My indentation offset")
(global-set-key (kbd "TAB") 'tab-to-tab-stop)
(setq tab-stop-list (number-sequence my-indent 200 my-indent))
(setq-default indent-tabs-mode nil)
(setq-default tab-always-indent nil)
(setq-default tab-width my-indent)
(defvaralias 'c-basic-offset 'my-indent)
(defvaralias 'cperl-indent-level 'my-indent)
;; disable electric indent
(electric-indent-mode -1)
(setq-default electric-indent-inhibit t)
(global-set-key "\C-m" 'newline-and-indent)

;; trim whitespace on changed lines after saving
(require 'ws-butler)
(add-hook 'prog-mode-hook #'ws-butler-mode)
;; allow deleting whitespace next to the cursor
(setq-default ws-butler-keep-whitespace-before-point nil)

;; display line numbers
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;; open *scratch* file when starting up
(setq inhibit-startup-screen t)

;;
;; Themes
;;
(if (eq system-type 'windows-nt)
    (set-face-attribute 'default nil :family "Consolas" :height 100)
)
