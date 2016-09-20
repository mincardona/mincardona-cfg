(require 'package)
;; Add the original Emacs Lisp Package Archive
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
;; Add the user-contributed repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(global-set-key (kbd "TAB") 'tab-to-tab-stop)
(setq indent-line-function 'tab-to-tab-stop)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
(setq-default make-backup-files nil)
;(setq-default cursor-type '(bar . 1))
(setq-default cursor-type 'bar)
(setq-default blink-cursor-blinks 0)

; Set your lisp system and, optionally, some contribs
(setq-default inferior-lisp "/usr/bin/clisp")
(setq-default inferior-lisp-program "/usr/bin/clisp")
(setq-default slime-contribs '(slime-fancy))
(setq-default slime-lisp-implementations
        '((clisp ("/usr/bin/clisp") ))
    )
