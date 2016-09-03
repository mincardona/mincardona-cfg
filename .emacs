(setq-default indent-tabs-mode nil);
(setq-default tab-width 4);
(global-set-key (kbd "TAB") 'tab-to-tab-stop);
(setq indent-line-function 'tab-to-tab-stop);
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
(setq-default make-backup-files nil);
