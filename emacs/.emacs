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

;(setq-default make-backup-files nil)
;; set the cursor type
(setq-default cursor-type '(bar . 1))
;(setq-default cursor-type 'box)
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
;; enable the mouse in terminals
(xterm-mouse-mode 1)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; move between windows using S-<left>, etc
(when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings))

(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)

;; save backup files in the temp directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;
;; Whitespace and indentation stuff
;;

(setq-default c-default-style "java")
(defvar my-indent 4 "My indentation offset")
(global-set-key (kbd "TAB") 'tab-to-tab-stop)
(setq tab-stop-list (number-sequence my-indent 200 my-indent))
(setq-default indent-tabs-mode nil)
(setq-default tab-always-indent nil)
(setq-default tab-width my-indent)
(defvaralias 'c-basic-offset 'my-indent)
(defvaralias 'cperl-indent-level 'my-indent)
;; disable electric indent
;; (electric-indent-mode -1)
;; disable electric indent affecting previous line on enter
(setq-default electric-indent-inhibit t)
(global-set-key "\C-m" 'newline-and-indent)
;; delete indentation on backspace
(setq backward-delete-char-untabify-method 'hungry)
;; don't indent in namespace{...}
(c-set-offset 'innamespace 0)

;; trim whitespace on changed lines after saving
(require 'ws-butler)
(add-hook 'prog-mode-hook #'ws-butler-mode)
;; allow deleting whitespace next to the cursor
(setq-default ws-butler-keep-whitespace-before-point nil)

(setq-default show-trailing-whitespace t)

;; display line numbers
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;; open *scratch* file when starting up
(setq inhibit-startup-screen t)
;; turn on highlighting in grep output
(setq grep-highlight-matches t)

;; enable extensions to the dired mode
(add-hook 'dired-load-hook
	  (function (lambda () (load "dired-x"))))

;; packages
(unless (package-installed-p 'diminish)
  (package-refresh-contents)
  (package-install 'diminish))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package company
  :init
  (global-company-mode))

(global-set-key (kbd "C-c f") 'company-complete)
(setq-default company-auto-complete-chars nil)
(setq-default company-selection-wrap-around t)
(company-tng-configure-default)
(setq-default company-idle-delay nil)
;;
;; Themes
;;
(if (eq system-type 'windows-nt)
    (set-face-attribute 'default nil :family "Consolas" :height 100)
)
