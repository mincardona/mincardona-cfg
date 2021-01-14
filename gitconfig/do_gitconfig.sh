#!/bin/bash

# remove old aliases
git config --global --unset alias.clrb

# set vim as git editor
command -v vim >/dev/null 2>&1 && git config --global core.editor vim

git config --global alias.gr "log --graph --decorate --all --date=short --format=format:'%C(bold magenta)%h%C(reset) %C(green)%an%C(dim green) [%cd]%C(reset)%C(auto)%d%C(reset): %C(white)%<(120,trunc)%s%C(reset)'"

git config --global alias.logdiff "log -p"
git config --global alias.logstat "log --stat"
git config --global alias.logcell "log --numstat"

git config --global merge.conflictstyle diff3

git config --global alias.br "branch"
git config --global alias.co "checkout"
git config --global alias.st "status"
git config --global alias.mkbr "checkout -b"
git config --global alias.dh "diff HEAD"
git config --global alias.cm "commit"
