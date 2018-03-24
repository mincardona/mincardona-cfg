#!/bin/bash

# bash
cp --preserve "bash/.bashrc" ~
cp --preserve "bash/.bash_aliases" ~

# vim
cp --preserve "vim/.vimrc" ~

# nano
cp --preserve "nano/.nanorc" ~

# emacs
cp --preserve "emacs/.emacs" ~

# gtksourceview
mkdir --parents ~/.local/share/gtksourceview-3.0/styles
cp --preserve "gtksourceview/jcd.xml" ~/.local/share/gtksourceview-3.0/styles/

# templates
if [ -d "~/Templates" ]; then
    cp --preserve ./templates/* ~/Templates/
fi

# sublime
mkdir -p ~/.config/sublime-text-3/Packages/User/
mkdir -p ~/.config/sublime-text-3/Packages/Custom\ Color\ Schemes/
cp --preserve "sublime/Preferences.sublime-settings" ~/.config/sublime-text-3/Packages/User/
cp --preserve "sublime/Default.sublime-keymap" ~/.config/sublime-text-3/Packages/User/
cp --preserve "sublime/Package Control.sublime-settings" ~/.config/sublime-text-3/Packages/User/
cp --preserve "sublime/jcd.tmTheme" ~/.config/sublime-text-3/Packages/Custom\ Color\ Schemes/

echo "done."
