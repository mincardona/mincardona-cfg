#!/bin/bash

# bash
cp -p "bash/.bashrc" ~
cp -p "bash/.bash_aliases" ~

# zsh
cp -p "zsh/.zshrc" ~

# vim
cp -p "vim/.vimrc" ~
mkdir -p ~/.vim/colors
cp vim/.vim/colors/* ~/.vim/colors/
mkdir -p ~/.vim/ftplugin
cp vim/.vim/ftplugin/* ~/.vim/ftplugin/
mkdir -p ~/.vim/plugin
cp vim/.vim/plugin/* ~/.vim/plugin/
mkdir -p ~/.vim/doc
cp vim/.vim/doc/* ~/.vim/doc/

# nano
cp -p "nano/.nanorc" ~

# emacs
mkdir -p ~/.emacs.d/lisp/
rm -f ~/.emacs.d/lisp/ws-butler.el
cp -p "emacs/.emacs" ~

# gtksourceview
mkdir -p ~/.local/share/gtksourceview-3.0/styles
cp -p "gtksourceview/jcd.xml" ~/.local/share/gtksourceview-3.0/styles/

# templates
if [ -d "~/Templates" ]; then
    cp -p ./templates/* ~/Templates/
fi

# sublime
# mkdir -p ~/.config/sublime-text-3/Packages/User/
# mkdir -p ~/.config/sublime-text-3/Packages/Custom\ Color\ Schemes/
# cp -p "sublime/Preferences.sublime-settings" ~/.config/sublime-text-3/Packages/User/
# cp -p "sublime/Default.sublime-keymap" ~/.config/sublime-text-3/Packages/User/
# cp -p "sublime/Package Control.sublime-settings" ~/.config/sublime-text-3/Packages/User/
# cp -p "sublime/jcd.tmTheme" ~/.config/sublime-text-3/Packages/Custom\ Color\ Schemes/

# vscode - now using settings sync instead
# mkdir -p ~/.config/Code/User
# cp -p "vscode/settings.json" ~/.config/Code/User/
# cp -p "vscode/keybindings.json" ~/.config/Code/User/
# mkdir -p ~/.vscode/extensions
# cp -p -r "vscode/extensions/michaelincardona.maclipse" ~/.vscode/extensions/

# tmux
cp -p "tmux/.tmux.conf" ~

# kate
cp -p kate/katerc ~/.config/katerc

echo "done."
