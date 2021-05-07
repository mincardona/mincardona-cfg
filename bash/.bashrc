#!/usr/bin/env bash
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything.
# The produces a consistent environment for shell scripts.
case $- in
    *i*) ;;
      *) return;;
esac

if [ -f /proc/version ] && grep -iq 'microsoft.*wsl' /proc/version; then
    IS_WSL="YES"
else
    IS_WSL="NO"
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enables "**" globbing
shopt -s globstar
# enables +(...), *(...), etc. globbing
shopt -s extglob

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

# detect color support
COLOR_TERM=no
case "$TERM" in
    xterm|xterm-color|*-256color) COLOR_TERM=yes
    ;;
esac

if [ "$COLOR_TERM" = yes ]; then
    if [ -x /usr/bin/dircolors ]; then
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

    export COLORTERM="$COLOR_TERM"
    export CLICOLOR="$COLOR_TERM"
else
    alias ls='ls -Fh'
    alias la='ls -FAh'
    alias ll='ls -Flh'
    alias lla='ls -Flah'
fi

if [ "$IS_WSL" = YES ] && [ -n "$LS_COLORS" ]; then
    # Remove the green background from other-writeable, non-sticky dirs
    # These are too common on WSL for the green background to be useful
    LS_COLORS=$(sed -r 's/(^|:)ow=[0-9;]+/\1ow=01;34/' <<<$LS_COLORS)
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# Additional files may need to be sourced from ~/.bash_platform
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        source /usr/share/bash-completion/bash_completion
    elif [ -f /usr/local/share/bash-completion/bash_completion.sh ]; then
        # FreeBSD
        source /usr/local/share/bash-completion/bash_completion.sh
    elif [ -f /etc/bash_completion ]; then
        source /etc/bash_completion
    fi
fi

function prompt_command {
    local RETCODE="$?"
    PS1=""
    local DEBIAN_CHROOT_STR=""
    # set variable identifying the chroot you work in on debian (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
        local debian_chroot=$(cat /etc/debian_chroot)
        DEBIAN_CHROOT_STR="${debian_chroot:+($debian_chroot)}"
    fi

    RED_STR='\[\e[1;31m\]'
    BOLD_GREEN_STR='\[\e[1;32m\]'
    BOLD_BLUE_STR='\[\e[1;34m\]'
    GIT_ST_COLOR='\[\e[1;35m\]'
    COLOR_RESET='\[\e[0m\]'

    local PROMPT_COLOR=""
    if [[ $EUID -eq 0 ]]; then
        PROMPT_COLOR="$RED_STR"
    else
        PROMPT_COLOR="$BOLD_BLUE_STR"
    fi

    local GIT_ST=""
    if command -v git 1>/dev/null 2>&1; then
        local BRANCH=""
        BRANCH=$(git branch --show-current 2>/dev/null)
        if [[ $? -eq 0 ]]; then
            GIT_ST=" ${GIT_ST_COLOR}($BRANCH)"
        fi
    fi

    local RETSTR=""
    if [[ $RETCODE -ne 0 ]]; then
       RETSTR=" ${RED_STR}[$RETCODE]"
    fi

    PS1="${DEBIAN_CHROOT_STR}${BOLD_GREEN_STR}\u@\h ${BOLD_BLUE_STR}\w${GIT_ST}${RETSTR}\n${PROMPT_COLOR}\$ ${COLOR_RESET}"

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${DEBIAN_CHROOT_STR}\u@\h:\w\a\]$PS1"
        ;;
    esac
}

PROMPT_DIRTRIM=3
PROMPT_COMMAND=prompt_command

bind '"\t":menu-complete'
bind '"\e[Z":menu-complete-backward'
export PAGER='less'

# Alias definitions from a separate file
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# Machine-specific configuration
if [ -f ~/.bash_platform ]; then
    source ~/.bash_platform
fi
