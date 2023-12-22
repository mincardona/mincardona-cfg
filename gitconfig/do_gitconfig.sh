#!/bin/bash

# remove old aliases
git config --global --unset alias.clrb

# set vim as git editor
#command -v vim >/dev/null 2>&1 && git config --global core.editor vim

git config --global alias.gr "log --graph --decorate --all --date=short --format=format:'%C(bold magenta)%h%C(reset) %C(green)%an%C(dim green) [%cd]%C(reset)%C(auto)%d%C(reset): %C(white)%<(120,trunc)%s%C(reset)'"

git config --global --unset alias.logdiff
git config --global --unset alias.logstat
git config --global --unset alias.logcell
git config --global --unset alias.log-line
git config --global --unset alias.log-short
git config --global --unset alias.log-med
git config --global --unset alias.log-full

# ignore whitespace: -w (--ignore-all-space)
# graph: --graph
# full commit hashes: --no-abbrev-commit
git config --global alias.logline "log --pretty=format:'%C(auto)%h%d [%an c.%cd]  %s' --date=format-local:'%Y-%m-%d'"
git config --global alias.logshort "log --pretty=format:'%C(green)commit %C(auto)%h%d%nAuthor: %an <%ae>%nC.Date: %cd%n%n%w(0,4,4)%s%n%n%-b' --date=local"
git config --global alias.logmed "log --pretty=format:'%C(green)commit %C(auto)%h%d%nAuthor: %an <%ae>%nC.Date: %cd%n%n%w(0,4,4)%s%n%n%-b' --compact-summary --date=local"
git config --global alias.logfull "log --pretty=format:'%C(green)commit %C(auto)%H%d%nAuthor: %an <%ae>%nC.Date: %cd%n%n%w(0,4,4)%s%n%n%-b' --compact-summary --date=local -p"

git config --global merge.conflictstyle diff3

git config --global pull.rebase true
git config --global fetch.prune true
git config --global diff.colorMoved default

git config --global alias.br "branch"
git config --global alias.co "checkout"
git config --global alias.st "status"
git config --global alias.mkbr "checkout -b"
git config --global alias.dh "diff HEAD"
git config --global alias.cm "commit"
git config --global alias.sw "switch"

# https://stackoverflow.com/a/42636500
# add these to gitconfig to use ediff as a difftool
# [difftool "ediff"]
#     cmd = emacs -nw --eval \"(ediff-files \\\"$LOCAL\\\" \\\"$REMOTE\\\")\"
# [difftool "ediffclient"]
#     cmd = emacsclient -nw -a= --eval \"(ediff-files \\\"$LOCAL\\\" \\\"$REMOTE\\\")\"
# then run
#   git config diff.tool ediff
# or
#   git config diff.tool ediffclient
# to set the difftool

git config --global difftool.ediff.cmd 'emacs -nw --eval "(ediff-files \"$LOCAL\" \"$REMOTE\")"'
git config --global difftool.ediffclient.cmd 'emacsclient -nw -a= --eval "(ediff-files \"$LOCAL\" \"$REMOTE\")"'
