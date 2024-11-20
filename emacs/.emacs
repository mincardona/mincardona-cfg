; set encoding before anything else
(prefer-coding-system 'utf-8-unix)

; load custom scripts
;(add-to-list 'load-path "~/.emacs.d/lisp")

;;
;; General settings
;;

;; require a single blank line at the end of each file
(setq-default require-final-newline t)
(setq-default delete-trailing-lines nil)
(setq sentence-end-double-space nil)
;; don't create backup files and clutter
(setq auto-save-default nil)

;; show parentheses when the cursor is on them
(show-paren-mode t)
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

;; uncomment this to exit this file early
;; (useful for troubleshooting slow startup)
;(with-current-buffer " *load*"
;  (goto-char (point-max)))

(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

;; fix gnu elpa connection
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(package-initialize)

;; save backup files in the temp directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;
;; Whitespace and indentation stuff
;;

; using Google style now
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
;(setq-default backward-delete-char-untabify-method 'hungry)
(setq-default backward-delete-char-untabify-method nil)
;; don't indent in namespace{...}
(c-set-offset 'innamespace 0)
(setq-default fill-column 80)

(add-hook 'html-mode-hook
    (lambda ()
      (set (make-local-variable 'sgml-basic-offset) 4)))

(setq-default show-trailing-whitespace t)

;; display line numbers
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))

;; open *scratch* file when starting up
(setq inhibit-startup-screen t)
;; turn on highlighting in grep output
(setq grep-highlight-matches t)

;; enable extensions to the dired mode
(add-hook 'dired-load-hook
  (function (lambda ()
    (load "dired-x")
    ; can still use e for the alternate functionality
    (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
    (define-key dired-mode-map (kbd "f") 'dired-find-alternate-file)
    (define-key dired-mode-map (kbd "<mouse-2>") 'dired-find-alternate-file)
)))

(put 'dired-find-alternate-file 'disabled nil)

;; use ibuffer instead of buffermenu
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; split ediff with a vertical line by default
(setq-default ediff-split-window-function 'split-window-horizontally)

;; comment and uncomment lines and regions
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Comment-Commands.html
(global-set-key (kbd "C-c /") 'comment-line)

;; kill entire line from anywhere
(global-set-key (kbd "M-p") 'kill-whole-line)

;; This variable seems to have no effect
;(setq-default ff-ignore-include t)
;(global-set-key (kbd "C-c o") 'ff-find-other-file)

;; Ignore #includes when finding other file
(defun my-ff-find-other-file ()
  (interactive)
  (ff-find-other-file nil t))
(global-set-key (kbd "C-c o") 'my-ff-find-other-file)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Make search case-sensitive
;; To toggle case sensitivity of the search, type M-c or M-s c while searching
(setq-default case-fold-search nil)

;; packages
(unless (package-installed-p 'diminish)
  (package-refresh-contents)
  (package-install 'diminish))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; trim whitespace on changed lines after saving
(use-package ws-butler
  :config
  (add-hook 'prog-mode-hook #'ws-butler-mode)
  ; allow deleting whitespace next to the cursor
  (setq-default ws-butler-keep-whitespace-before-point nil))

(defconst redcom-c-style
  '("Google"
  (c-basic-offset . 4)
  (c-offsets-alist
    (access-label . /)      ; for inclass and access-label combined
    (arglist-cont . 0)      ; Guessed value
    (arglist-intro . ++)    ; Guessed value
    (case-label . +)        ; Guessed value
    (class-close . 0)       ; Guessed value
    (defun-block-intro . +) ; Guessed value
    (defun-close . 0)       ; Guessed value
    (inclass . +)           ; Guessed value
    (inline-close . 0)      ; Guessed value
    (innamespace . 0)       ; Guessed value
    (member-init-cont . 0)  ; Guessed value
    (member-init-intro . +) ; Guessed value
    (namespace-close . 0)   ; Guessed value
    (statement . 0)         ; Guessed value
    (statement-block-intro . +) ; Guessed value
    (statement-case-intro . +) ; Guessed value
    (statement-cont . ++)      ; Guessed value
    (topmost-intro . 0)     ; Guessed value
    (topmost-intro-cont . 0) ; was guessed as ++
  )
))

(use-package google-c-style
  :config
  ;(add-hook 'c-mode-common-hook 'google-set-c-style)
  ;(add-hook 'c-mode-common-hook (lambda () (setq-default c-basic-offset my-indent)))
  (add-hook 'c-mode-common-hook #'(lambda ()
    (c-add-style "Google" google-c-style)
    (c-add-style "redcom" redcom-c-style t)
  ))
)

(use-package protobuf-mode)

;(use-package lsp-mode
;    :commands (lsp lsp-deferred)
;    :hook (c++-mode . lsp-deferred) (c-mode . lsp-deferred)
;    :config (setq-default lsp-clients-clangd-executable "clangd10"))

;(use-package lsp-ui
;    :commands lsp-ui-mode)

;(use-package company
;  :init
;  (global-company-mode)
;  :config
;  (global-set-key (kbd "C-c c") 'company-manual-begin)
;  (setq-default company-auto-complete-chars nil)
;  (setq-default company-selection-wrap-around t)
;  (setq-default company-idle-delay nil)
;  ;(company-tng-configure-default)
;)

;;; (setq company-backends (delete 'company-semantic company-backends))

;(use-package company-lsp
;    :commands company-lsp)

;(use-package flycheck
;  :ensure t
;  :init (global-flycheck-mode))

(use-package vscode-dark-plus-theme
  :config
  (load-theme 'vscode-dark-plus t))

; use markdown mode for arc diffs (and git commits)
(use-package markdown-mode
  :config
  ;https://www.emacswiki.org/emacs/AutoModeAlist
  (add-to-list 'auto-mode-alist '("/new-commit\\(<.*>\\)?\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("/differential-update-comments\\'" . markdown-mode)))

(use-package magit
  :config
  (remove-hook 'server-switch-hook 'magit-commit-diff)
  (remove-hook 'with-editor-filter-visit-hook 'magit-commit-diff)
  (magit-auto-revert-mode 0)
  (global-auto-revert-mode t)
  (setq-default git-commit-major-mode 'markdown-mode)
)

(use-package web-mode
    :config
    (setq-default web-mode-enable-current-element-highlight t)
    (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.s?css\\'" . web-mode))
)

(use-package clang-format
    :config
    (setq-default clang-format-style "file")
    (setq-default clang-format-executable "/usr/local/bin/clang-format15")
    (setq-default clang-format-fallback-style "none")
    (global-set-key (kbd "C-c f") 'clang-format-region))

(use-package mwim
    :config
    (global-set-key (kbd "C-a") 'mwim-beginning))

;;
;; Custom functions
;;

;; https://emacs.stackexchange.com/a/50730
(defun revert-all-buffers ()
  "Revert all open buffers from their respective files."
  (interactive)
  (let* ((list (buffer-list))
         (buffer (car list)))
    (while buffer
      (let ((filename (buffer-file-name buffer)))
        ;; Revert only buffers containing files;
        ;; do not try to revert non-file buffers like *Messages*.
        (when filename
          (if (file-exists-p filename)
              ;; If the file exists, revert the buffer.
              (with-demoted-errors "Error: %S"
                (with-current-buffer buffer
                  (revert-buffer :ignore-auto :noconfirm :preserve-modes)))
              ;; If the file doesn't exist, signal an error.
              (error "File for buffer no longer exists: %s" buffer)))
        (setq buffer (pop list)))))
  (message "Finished reverting buffers."))

(defun mji/include-guard (macro_symbol)
    (interactive "sMacro symbol: ")
    (move-beginning-of-line nil)
    (when (string=
            ""
            (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
        ; insert two blank lines and move to the top one
        (open-line 1))
    (let ((point-bak (point)))
        (insert "#ifndef " macro_symbol "\n#define " macro_symbol "\n")
        (goto-char (point-max))
        (open-line 1)
        (insert "#endif  // " macro_symbol)
        (goto-char point-bak)))

(defun mji/class-new (class_name is_virtual)
    (interactive
        (list (read-string "Class name: ")
              (y-or-n-p "Make virtual? ")))
    (when (string=
            ""
            (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
        (move-end-of-line nil)
        (open-line 1))
    (let ((point-bak (point)))
        (insert "class " class_name " {\n")
        (insert "\n")
        (insert "}")
        (goto-char point-bak)))

(defun mji/scons-git ()
    "Run scons on the current Git repository"
    (interactive)
    (compile "scons -C \"$(git rev-parse --show-toplevel)\""))

(defun mji/scons-git-debug ()
    "Run scons DEBUG=1 on the current Git repository"
    (interactive)
    (compile "scons -C \"$(git rev-parse --show-toplevel)\" DEBUG=1"))

;;
;; Themes
;;
(if (eq system-type 'windows-nt)
    (set-face-attribute 'default nil :family "Consolas" :height 100)
)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("79bc32a7c8da2ca2dd33591df9485258293e0e6e03d0ff4a2403a6882dcfdb2b" default))
 '(package-selected-packages '(vscode-dark-plus-theme use-package diminish)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
