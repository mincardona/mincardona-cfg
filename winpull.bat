@echo off

REM Emacs
MKDIR "%APPDATA%\.emacs.d\lisp"
COPY /Y emacs\.emacs "%APPDATA%\.emacs"

DEL /Q "%APPDATA%\.emacs.d\lisp\ws-butler.el"

REM nano
COPY /Y nano\.nanorc "%USERPROFILE%\.nanorc"

REM Vim
COPY /Y vim\.vimrc "%USERPROFILE%\.vimrc"
MKDIR "%USERPROFILE%\vimfiles\colors"
COPY /Y vim\.vim\colors\* "%USERPROFILE%\vimfiles\colors\"
MKDIR "%USERPROFILE%\vimfiles\ftplugin"
COPY /Y vim\.vim\ftplugin\* "%USERPROFILE%\vimfiles\ftplugin\"
MKDIR "%USERPROFILE%\vimfiles\plugin"
COPY /Y vim\.vim\plugin\* "%USERPROFILE%\vimfiles\plugin\"
MKDIR "%USERPROFILE%\vimfiles\doc"
COPY /Y vim\.vim\doc\* "%USERPROFILE%\vimfiles\doc\"

REM bash
COPY /Y bash\.bashrc "%USERPROFILE%\.bashrc"
COPY /Y bash\.bash_aliases "%USERPROFILE%\.bash_aliases"

REM Sublime Text 3
MKDIR "%APPDATA%\Sublime Text 3\Packages\Custom Color Schemes\"
MKDIR "%APPDATA%\Sublime Text 3\Packages\User\"
COPY /Y sublime\Preferences.sublime-settings "%APPDATA%\Sublime Text 3\Packages\User\"
COPY /Y "sublime\Package Control.sublime-settings" "%APPDATA%\Sublime Text 3\Packages\User\"
COPY /Y sublime\Default.sublime-keymap "%APPDATA%\Sublime Text 3\Packages\User\"
COPY /Y sublime\jcd.tmTheme "%APPDATA%\Sublime Text 3\Packages\Custom Color Schemes\"

REM vscode - now using settings sync instead
REM MKDIR "%APPDATA%\Code\User\"
REM COPY /Y vscode\settings.json "%APPDATA%\Code\User\"
REM COPY /Y vscode\keybindings.json "%APPDATA%\Code\User\"
REM MKDIR "%USERPROFILE%\.vscode\extensions\michaelincardona.maclipse\themes"
REM COPY /Y vscode\extensions\michaelincardona.maclipse\themes\maclipse.json "%USERPROFILE%\.vscode\extensions\michaelincardona.maclipse\themes\"
REM COPY /Y vscode\extensions\michaelincardona.maclipse\package.json "%USERPROFILE%\.vscode\extensions\michaelincardona.maclipse\"

REM Kate
COPY /Y kate\katerc "%LOCALAPPDATA%\katerc"
