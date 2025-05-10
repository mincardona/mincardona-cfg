# $PROFILE.CurrentUserAllHosts

# Check Get-PSReadlineOption for fields
$readLineOptions = @{
    EditMode = "Emacs"
    BellStyle = "Visual"
    
    Colors = @{
        Command = "white"
        Keyword = "darkcyan"
        Operator = "white"
        Parameter = "white"
        Variable = "white"
        String = "darkgreen"
    }

    PredictionSource = "None"
}
Set-PSReadLineOption @readLineOptions

# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_prompts
# default prompt is
# "PS $($ExecutionContext.SessionState.Path.CurrentLocation)$('>' * ($NestedPromptLevel + 1)) "
function prompt {
    $lastcode = $?
    
    # https://learn.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences
    $ESC = [char]27
    $prompt_bgreen = "$ESC[;92m"
    $prompt_bblue = "$ESC[;94m"
    $prompt_bred = "$ESC[;91m"
    #note: bold must go after color change
    $prompt_bold = "$ESC[1m"
    $prompt_unbold = "$ESC[22m"
    $prompt_reset = "$ESC[0m"
    
    "$prompt_bgreen$prompt_bold$Env:UserName@$Env:ComputerName $prompt_bblue$prompt_bold$($ExecutionContext.SessionState.Path.CurrentLocation)$(if ($lastcode) {''} else {`" ${prompt_bred}${prompt_bold}[!]`"})$prompt_reset`r`n$prompt_bblue$prompt_bold$('+'*(Get-Location -Stack).Count)$('>'*($NestedPromptLevel + 1))$prompt_reset "
}

function git-status-alias-fn {
    git status
}
Set-Alias -Name lg -Value git-status-alias-fn

function ls-all {
    ls -Force
}
Set-Alias -Name la -Value ls-all

Set-Alias -Name which -Value Get-Command
