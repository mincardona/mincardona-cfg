alias lg='git status'
alias temacs='emacs -nw'
alias tcemacs='emacsclient -nw -a=""'
alias demacs='emacs --daemon'
alias kemacs='emacsclient --eval "(kill-emacs)"'
alias tvim='vim -X'
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
