#!/bin/bash

# bash
cp --preserve "bash/.bashrc" ~
cp --preserve "bash/.bash_aliases" ~

# zsh
cp --preserve "zsh/.zshrc" ~

# vim
cp --preserve "vim/.vimrc" ~
mkdir -p ~/.vim/colors
cp vim/.vim/colors/* ~/.vim/colors/
mkdir -p ~/.vim/ftplugin
cp vim/.vim/ftplugin/* ~/.vim/ftplugin/
mkdir -p ~/.vim/plugin
cp vim/.vim/plugin/* ~/.vim/plugin/
mkdir -p ~/.vim/doc
cp vim/.vim/doc/* ~/.vim/doc/

# nano
cp --preserve "nano/.nanorc" ~

# emacs
mkdir -p ~/.emacs.d/lisp/
rm -f ~/.emacs.d/lisp/ws-butler.el
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

# vscode - now using settings sync instead
# mkdir -p ~/.config/Code/User
# cp --preserve "vscode/settings.json" ~/.config/Code/User/
# cp --preserve "vscode/keybindings.json" ~/.config/Code/User/
# mkdir -p ~/.vscode/extensions
# cp --preserve -r "vscode/extensions/michaelincardona.maclipse" ~/.vscode/extensions/

# tmux
cp --preserve "tmux/.tmux.conf" ~

echo "done."
