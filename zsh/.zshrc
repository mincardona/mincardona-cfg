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
# do not split words in unquoted parameter expansions (this is the default)
unsetopt sh_word_split
# disable escape sequences in echo unless -e is passed
setopt bsd_echo

# make git and svn info available to prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*' formats " (%b)"
precmd() {
    vcs_info
}

# perform substitutions in the prompt string
setopt prompt_subst
PROMPT='%B%F{green}%n@%m %F{blue}%3~%F{magenta}${vcs_info_msg_0_}%b%(?.. %F{red}[%?])'$'\n''%B%(!.%F{red}#.%F{blue}$)%f%b '

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
case $TERM in
    xterm|xterm-color|*-256color) color_term=yes
    ;;
esac
if [[ -n $COLORTERM || -n $CLI_COLOR || -n $CLICOLOR ]]; then
    color_term=yes
fi

if [[ -n $color_term ]]; then
    if [[ -x /usr/bin/dircolors ]]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    fi

    alias ls='ls --color=auto -Fh'
    alias la='ls --color=auto -FAh'
    alias ll='ls --color=auto -Flh'
    alias lla='ls --color=auto -Flah'

    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
else
    alias ls='ls -Fh'
    alias la='ls -FAh'
    alias ll='ls -Flh'
    alias lla='ls -Flah'
fi

# OS stuff

if [ -f /proc/version ] && grep -iq 'microsoft.*wsl' /proc/version; then
    is_wsl=YES
fi

is_bsd_like="$(uname -s)"
if [[ $is_bsd_like = *BSD* || $is_bsd_like = Darwin ]]; then
    is_bsd_like=YES
fi

if [[ -n $is_wsl && -n $LS_COLORS ]]; then
    # Remove the green background from other-writeable, non-sticky dirs.
    # These are too common on WSL for the green background to be useful
    export LS_COLORS="$(sed -r 's/(^|:)ow=[0-9;]+/\1ow=01;34/' <<<$LS_COLORS)"
fi

if [[ -n $is_bsd_like ]]; then
    export LSCOLORS=ExGxFxdaCxDaDahbadacec
    if [[ -n $color_term ]]; then
        : ${CLICOLOR=1}
        : ${COLORTERM=1}
        export CLICOLOR
        export COLORTERM
    fi
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
alias tvim='vim -X'
alias ping4='ping -c 4'
alias follow='less --follow-name +F'
alias followstdin='less +F'

function mkcd {
    mkdir -p $1 && cd $1 && pwd
}

function math() {
    echo $1 | bc -l
}

if [[ -f ~/.zsh_platform ]]; then
    source ~/.zsh_platform
fi

# Configure zsh syntax highlighting. This should happen last
function () {
    local colorA=fg=green
    local colorB=fg=cyan
    local colorC=fg=green
    local colorD=fg=blue,bold
    local colorE=fg=red,bold

    local colorG=fg=black,bold
    local colorH=fg=magenta,bold
    local colorI=fg=white,bold
    local colorJ=fg=blue
    local colorK=fg=yellow

    typeset -ga ZSH_HIGHLIGHT_HIGHLIGHTERS
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

    typeset -gA ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_STYLES[default]=none
    ZSH_HIGHLIGHT_STYLES[unknown-token]=none
    ZSH_HIGHLIGHT_STYLES[reserved-word]=$colorI
    ZSH_HIGHLIGHT_STYLES[suffix-alias]=none
    ZSH_HIGHLIGHT_STYLES[global-alias]=none
    ZSH_HIGHLIGHT_STYLES[precommand]=none
    ZSH_HIGHLIGHT_STYLES[commandseparator]=$colorH
    ZSH_HIGHLIGHT_STYLES[autodirectory]=none
    ZSH_HIGHLIGHT_STYLES[path]=none
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[globbing]=none
    ZSH_HIGHLIGHT_STYLES[history-expansion]=$colorJ
    ZSH_HIGHLIGHT_STYLES[command-substitution]=none
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=none
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]=$colorC
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]=$colorD
    ZSH_HIGHLIGHT_STYLES[process-substitution]=none
    ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=$colorK
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=$colorD
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=$colorB
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=$colorB
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=$colorB
    ZSH_HIGHLIGHT_STYLES[rc-quote]=$colorC
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=$colorC
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=$colorC
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=$colorC
    ZSH_HIGHLIGHT_STYLES[assign]=none
    ZSH_HIGHLIGHT_STYLES[redirection]=$colorK
    ZSH_HIGHLIGHT_STYLES[comment]=$colorG
    ZSH_HIGHLIGHT_STYLES[named-fd]=$colorK
    ZSH_HIGHLIGHT_STYLES[numeric-fd]=$colorK
    ZSH_HIGHLIGHT_STYLES[arg0]=none
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]=$colorE
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]=$colorE
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]=$colorE
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]=$colorE

    local zsh_syntax_hl_dirs=(
        /usr/local/share/zsh-syntax-highlighting
        /usr/share/zsh-syntax-highlighting
    )

    for dir in $zsh_syntax_hl_dirs; do
        if [[ -f $dir/zsh-syntax-highlighting.zsh ]]; then
            source $dir/zsh-syntax-highlighting.zsh
            break
        fi
    done
}
