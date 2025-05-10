# $PROFILE.CurrentUserAllHosts

if (!(Test-Path .\winpull.ps1)) {
    Write-Error "This script must be run from the repo directory"
    Exit 1
}

$platform = $PSVersionTable.Platform
if ($platform -eq $null) {
    $platform = "Win32NT"
}

# https://devblogs.microsoft.com/scripting/powertip-identify-which-platform-powershell-is-running-on/
if ($platform -ne "Win32NT") {
    Write-Error "This script only supports Windows right now"
    Exit 1
}

$appdata = $env:APPDATA
$localappdata = $env:APPDATA
$userprofile = $env:USERPROFILE
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles
$profiledest = $PROFILE.CurrentUserAllHosts

# emacs
New-Item -Type Directory -Force $appdata\.emacs.d\lisp | Out-Null
Copy-Item .\emacs\.emacs $appdata
Remove-Item $appdata\.emacs.d\lisp\ws-butler.el -Force -ErrorAction SilentlyContinue

# nano
Copy-Item .\nano\.nanorc $appdata\.nanorc

# vim
Copy-Item .\vim\.vimrc $userprofile
New-Item -Type Directory -Force $userprofile\vimfiles\colors | Out-Null
Copy-Item .\vim\.vim\colors\* $userprofile\vimfiles\colors
New-Item -Type Directory -Force $userprofile\vimfiles\ftplugin | Out-Null
Copy-Item .\vim\.vim\ftplugin\* $userprofile\vimfiles\ftplugin
New-Item -Type Directory -Force $userprofile\vimfiles\plugin | Out-Null
Copy-Item .\vim\.vim\plugin\* $userprofile\vimfiles\plugin
New-Item -Type Directory -Force $userprofile\vimfiles\doc | Out-Null
Copy-Item .\vim\.vim\doc\* $userprofile\vimfiles\doc

# bash
Copy-Item .\bash\.bashrc $userprofile
Copy-Item .\bash\.bash_aliases $userprofile

# powershell
Copy-Item .\powershell\profile.ps1 $profiledest

# sublime text 3
# (unimplemented)

# vscode
# (unimplemented; using settings sync instead)

# kate
Copy-Item .\kate\katerc $localappdata
