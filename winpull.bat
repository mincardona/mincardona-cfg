@echo off

REM Emacs
XCOPY /Y emacs\.emacs "%APPDATA%\.emacs"

REM nano
XCOPY /Y nano\.nanorc "%USERPROFILE%\.nanorc"

REM Vim
XCOPY /Y vim\.vimrc "%USERPROFILE%\.vimrc"

REM bash
XCOPY /Y bash\.bashrc "%USERPROFILE%\.bashrc"
XCOPY /Y bash\.bash_aliases "%USERPROFILE%\.bash_aliases"

REM Sublime Text 3
MKDIR "%APPDATA%\Sublime Text 3\Packages\Custom Color Schemes\"
MKDIR "%APPDATA%\Sublime Text 3\Packages\User\"
XCOPY /Y sublime\Preferences.sublime-settings "%APPDATA%\Sublime Text 3\Packages\User\"
XCOPY /Y sublime\Default.sublime-keymap "%APPDATA%\Sublime Text 3\Packages\User\"
XCOPY /Y sublime\jcd.tmTheme "%APPDATA%\Sublime Text 3\Packages\Custom Color Schemes\"
