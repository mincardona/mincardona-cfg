# If not running interactively, don't do anything.
# The produces a consistent environment for shell scripts.
if ! [[ -o interactive ]]; then
    return
fi

# don't correct spelling of commands
unsetopt correct
# don't correct spelling of arguments
unsetopt correct_all
# beep on error in line editor
setopt beep
# error on glob with no match
setopt nomatch
# don't change to directories without cd
unsetopt autocd
# don't treat # ~ or ^ as part of globs, except for initial ~ -> $HOME
unsetopt extendedglob
# treat @*+?! specially before (...)
# equivalent to bash's extglob
setopt ksh_glob
# disables () having special meaning at end of pattern
# it tends to conflict with ksh_glob patterns
unsetopt bare_glob_qual

# make git and svn info available to prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*' formats " (%b)"
precmd() {
    vcs_info
}

# perform substitutions in the prompt string
setopt prompt_subst
PROMPT='%B%F{green}%n@%m %F{blue}%3~%F{magenta}${vcs_info_msg_0_}%b%(?.. %F{red}[%?])'$'\n''%B%(!.%F{red}#.%F{blue}%%)%f%b '

# completion settings

setopt auto_list
setopt list_beep
unsetopt auto_menu
unsetopt list_ambiguous

# initialize new style completion
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' path-completion false
zstyle :compinstall filename '/home/michael/.zshrc'
autoload -Uz compinit
compinit

# history settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# color settings

if [[ $COLOR_TERM = yes || $COLORTERM = yes || $CLI_COLOR = yes ]]; then
    COLOR_TERM=yes
    COLORTERM=yes
    CLICOLOR=yes
fi

if [[ $COLOR_TERM = yes ]]; then
    if [[ -x /usr/bin/dircolors ]]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    fi

    alias ls='ls --color=auto -Fh'
    alias la='ls --color=auto -FAh'
    alias ll='ls --color=auto -Flh'
    alias lla='ls --color=auto -Flah'

    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
else
    alias ls='ls -Fh'
    alias la='ls -FAh'
    alias ll='ls -Flh'
    alias lla='ls -Flah'
fi

if [[ $IS_WSL = YES && -n $LS_COLORS ]]; then
    # Remove the green background from other-writeable, non-sticky dirs
    # These are too common on WSL for the green background to be useful
    LS_COLORS="$(sed -r 's/(^|:)ow=[0-9;]+/\1ow=01;34/' <<<$LS_COLORS)"
fi

# keyboard shortcuts

# use emacs keyboard shortcuts
bindkey -e
# ctrl-left and -right
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# aliases

# allows executing another alias through sudo
alias sudo='sudo '
alias lg='git status'
alias temacs='emacs -nw'
alias tcemacs='emacsclient -nw -a=""'
alias demacs='emacs --daemon'
alias kemacs='emacsclient --eval "(kill-emacs)"'
alias ping4='ping -c 4'

function mkcd {
    mkdir $1
    cd $1
    pwd
}

function math() {
    echo $1 | bc -l
}

if [[ -f ~/.zsh_platform ]]; then
    source ~/.zsh_platform
fi
