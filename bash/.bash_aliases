# some more ls aliases [taken from .bashrc]
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

# ls aliases
alias l='ls -F'
alias la='ls -FA'
alias ll='ls -Fl'
alias lla='ls -Fla'

alias lg='git status'

alias temacs='emacs -nw'
alias ping4='ping -c 4'

mkcd() {
    mkdir $1;
    cd $1;
}

cdls() {
    cd $1;
    echo "$(ls -F)";
}

cdla() {
    cd $1;
    echo "$(ls -alF)";
}

math() {
    echo "$1" | bc -l;
}

alias sudo='sudo '
alias arpclear='ip -s -s neigh flush all'

alias pls='sudo '
alias please='sudo '
alias pl0x='sudo '
alias plox='sudo '

alias killfire='kill -9'
