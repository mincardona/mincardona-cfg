#!/bin/bash

echo "performing standard ops..."

SHDIR=sh

cp --preserve ".bashrc" ~
cp --preserve ".bash_aliases" ~
cp --preserve ".vimrc" ~
cp --preserve ".nanorc" ~
cp --preserve ".emacs" ~
mkdir --parents ~/.local/share/gtksourceview-3.0/styles
cp --preserve "jcd.xml" ~/.local/share/gtksourceview-3.0/styles/
cp --preserve ./templates/* ~/Templates/

#unzip -o vimacs-master.zip
#mkdir -p $HOME/.vim/doc
#mkdir -p $HOME/.vim/plugin
#cp -R vimacs-master/doc vimacs-master/plugin $HOME/.vim
#vim --cmd "helptags $HOME/.vim/doc" --cmd "q"
#rm -rf vimacs-master

if [[ "$EUID" = 0 ]];
then
    echo "performing root ops..."
    cp --preserve "$SHDIR/spinoff" /usr/local/bin/
    cp --preserve "$SHDIR/ritnetreg" /usr/local/bin/
fi

echo "done."
