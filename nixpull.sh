#!/bin/bash

echo "performing standard ops..."

SHDIR=sh

cp ".bashrc" ~
cp ".bash_aliases" ~
cp ".vimrc" ~
cp ".nanorc" ~
cp ".emacs" ~
mkdir --parents ~/.local/share/gtksourceview-3.0/styles
cp "jcd.xml" ~/.local/share/gtksourceview-3.0/styles/
cp ./templates/* ~/Templates/

#unzip -o vimacs-master.zip
#mkdir -p $HOME/.vim/doc
#mkdir -p $HOME/.vim/plugin
#cp -R vimacs-master/doc vimacs-master/plugin $HOME/.vim
#vim --cmd "helptags $HOME/.vim/doc" --cmd "q"
#rm -rf vimacs-master

if [[ "$EUID" = 0 ]];
then
    echo "performing root ops..."
    cp "$SHDIR/spinoff" /usr/local/bin/
    cp "$SHDIR/ritnetreg" /usr/local/bin/
fi

echo "done."
