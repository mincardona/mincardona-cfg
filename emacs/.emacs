;;
;; Load emacs 24's package system. Add MELPA repository.
;;

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
(package-initialize)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))

;; https://github.com/jwiegley/use-package
(eval-when-compile
    (require 'use-package))
(setq use-package-always-ensure t)

;;
;; Package config
;;

;; (use-package tabbar
;;     :bind (
;;         ("M-<left>" . tabbar-backward-tab)
;;         ("M-<right>" . tabbar-forward-tab)
;;     )
;;     :config
;;     (defun my-tabbar-buffer-groups () ;; customize to show all normal files in one group
;;         "Returns the name of the tab group names the current buffer belongs to.
;;         There are two groups: Emacs buffers (those whose name starts with '*', plus
;;         dired buffers), and the rest.  This works at least with Emacs v24.2 using
;;         tabbar.el v1.7."
;;     (list (cond ((string-equal "*" (substring (buffer-name) 0 1)) "emacs")
;;                ((eq major-mode 'dired-mode) "emacs")
;;                (t "user"))))
;;     (setq tabbar-buffer-groups-function 'my-tabbar-buffer-groups)
;;     (tabbar-mode)
;; )

(use-package nlinum
    :config
    (global-nlinum-mode)
)

(use-package afternoon-theme
    :config
    ;; use t to avoid safety prompt each time
    (load-theme 'afternoon t)
)

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

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; move between windows using S-arrow
(when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings))

;;
;; Whitespace and indentation stuff
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
;; Themes
;;
(if (eq system-type 'windows-nt)
    (set-face-attribute 'default nil :family "Consolas" :height 100)
    (set-face-attribute 'default nil :family "DejaVu Sans" :height 100)
)

;;
;; Emacs custom set
;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#dddddd" "#222222" "#555555" "#000000" "#000000" "#222222" "#000000" "#000000"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (afternoon)))
 '(custom-safe-themes
   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "cab317d0125d7aab145bc7ee03a1e16804d5abdfa2aa8738198ac30dc5f7b569" "39dd7106e6387e0c45dfce8ed44351078f6acd29a345d8b22e7b8e54ac25bac4" "b550fc3d6f0407185ace746913449f6ed5ddc4a9f0cf3be218af4fb3127c7877" "28ec8ccf6190f6a73812df9bc91df54ce1d6132f18b4c8fcc85d45298569eb53" "7bf64a1839bf4dbc61395bd034c21204f652185d17084761a648251041b70233" "1f3113447a652b8436a9938bbac71ecaf022cc73ecd0d76182eb9713aa781f17" "4bfced46dcfc40c45b076a1758ca106a947b1b6a6ff79a3281f3accacfb3243c" "38e66a2a20fa9a27af5ffc4f4dd54f69e3fef6b51be7b351e137b24958bfebd7" "e3fc83cdb5f9db0d0df205f5da89af76feda8c56d79a653a5d092c82c7447e02" default)))
 '(ensime-sem-high-faces
   (quote
    ((var :foreground "#000000" :underline
          (:style wave :color "yellow"))
     (val :foreground "#000000")
     (varField :foreground "#600e7a" :slant italic)
     (valField :foreground "#600e7a" :slant italic)
     (functionCall :foreground "#000000" :slant italic)
     (implicitConversion :underline
                         (:color "#c0c0c0"))
     (implicitParams :underline
                     (:color "#c0c0c0"))
     (operator :foreground "#000080")
     (param :foreground "#000000")
     (class :foreground "#20999d")
     (trait :foreground "#20999d" :slant italic)
     (object :foreground "#5974ab" :slant italic)
     (package :foreground "#000000")
     (deprecated :strike-through "#000000"))))
 '(fci-rule-color "#eeeeee")
 '(fringe-mode 6 nil (fringe))
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(inhibit-startup-screen t)
 '(linum-format " %7d ")
 '(magit-diff-use-overlays nil)
 '(main-line-color1 "#191919")
 '(main-line-color2 "#111111")
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
   (quote
    (use-package monochrome-theme gotham-theme afternoon-theme intellij-theme nlinum tabbar)))
 '(pdf-view-midnight-colors (quote ("#eeeeee" . "#000000")))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(powerline-color1 "#191919")
 '(powerline-color2 "#111111")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background "#eeeeee")
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#d54e53")
     (40 . "goldenrod")
     (60 . "#e7c547")
     (80 . "DarkOliveGreen3")
     (100 . "#70c0b1")
     (120 . "DeepSkyBlue1")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "goldenrod")
     (200 . "#e7c547")
     (220 . "DarkOliveGreen3")
     (240 . "#70c0b1")
     (260 . "DeepSkyBlue1")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "goldenrod")
     (340 . "#e7c547")
     (360 . "DarkOliveGreen3"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
