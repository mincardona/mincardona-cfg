# some more ls aliases [taken from .bashrc]
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

# ls aliases
alias l='ls -Fh'
alias la='ls -FAh'
alias ll='ls -Flh'
alias lla='ls -Flah'

alias lg='git status'

alias temacs='emacs -nw'
alias ping4='ping -c 4'

mkcd() {
    mkdir "$1"
    cd "$1"
    pwd
}

math() {
    echo "$1" | bc -l;
}

# allows executing another alias through sudo
alias sudo='sudo '
