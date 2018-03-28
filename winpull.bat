@echo off

REM Emacs
COPY /Y emacs\.emacs "%APPDATA%\.emacs"

REM nano
COPY /Y nano\.nanorc "%USERPROFILE%\.nanorc"

REM Vim
MKDIR "%USERPROFILE%\.vim\colors"
COPY /Y vim\.vim\colors\* "%USERPROFILE%\.vim\colors\"
COPY /Y vim\.vimrc "%USERPROFILE%\.vimrc"

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
