unsetopt correct_all
unsetopt correct
setopt MENU_COMPLETE
unsetopt AUTO_LIST
unsetopt BASH_AUTO_LIST

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*' formats " (%b)"
precmd() {
    vcs_info
}
setopt prompt_subst
PROMPT='%B%F{green}%n@%m %F{blue}%3~%F{magenta}${vcs_info_msg_0_}%b%(?.. %F{red}[%?])'$'\n''%B%(!.%F{red}z#.%F{blue}z$)%f%b '

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' path-completion false
zstyle :compinstall filename '/home/michael/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep nomatch
unsetopt autocd extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
