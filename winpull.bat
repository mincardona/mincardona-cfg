@echo off

REM Emacs
XCOPY /Y /Q emacs\.emacs "%APPDATA%\.emacs"

REM nano
XCOPY /Y /Q nano\.nanorc "%USERPROFILE%\.nanorc"

REM Vim
XCOPY /Y /Q vim\.vimrc "%USERPROFILE%\.vimrc"

REM bash
XCOPY /Y /Q bash\.bashrc "%USERPROFILE%\.bashrc"
XCOPY /Y /Q bash\.bash_aliases "%USERPROFILE%\.bash_aliases"

REM Sublime Text 3
MKDIR "%APPDATA%\Sublime Text 3\Packages\Custom Color Schemes\"
MKDIR "%APPDATA%\Sublime Text 3\Packages\User\"
XCOPY /Y /Q sublime\Preferences.sublime-settings "%APPDATA%\Sublime Text 3\Packages\User\"
XCOPY /Y /Q sublime\Default.sublime-keymap "%APPDATA%\Sublime Text 3\Packages\User\"
XCOPY /Y /Q sublime\jcd.tmTheme "%APPDATA%\Sublime Text 3\Packages\Custom Color Schemes\"
