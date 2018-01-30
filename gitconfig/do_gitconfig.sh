#!/bin/bash

git config --global alias.gr "log --graph --decorate --all --date=short --format=format:'%C(bold magenta)%h%C(reset) %C(green)%an%C(dim green) [%cd]%C(reset)%C(auto)%d%C(reset): %C(white)%<(120,trunc)%s%C(reset)'"
git config --global alias.logdiff "log -p"
git config --global alias.logstat "log --stat"
git config --global alias.logcell "log --numstat"
