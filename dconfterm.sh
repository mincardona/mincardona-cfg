# requires dconf-cli package

if [[ "$#" -ne 2 ]]
then
    echo "Usage: dconf-term COMMAND FILE"
    echo "A single dash ( - ) can be used to refer \
to stdin or stdout, where appropriate"
fi

if [[ "$1" = "import" ]]
then
    echo "importing from $2..."
    if [[ "$2" = "-" ]]
    then
        $2="/dev/stdin"
    fi
    cat "$2" | dconf load /org/gnome/terminal/legacy/profiles:/
elif [[ "$1" = "export" ]]
then
    echo "exporting to $2..."
    if [[ "$2" = "-" ]]
    then
        $2="/dev/stdout"
    fi
    dconf dump /org/gnome/terminal/legacy/profiles:/ >"$2"
fi

# import from $2
# dconf reset -f /org/gnome/terminal/legacy/profiles:/
# cat "$2" | dconf load /org/gnome/terminal/legacy/profiles:/

# export
# dconf dump /org/gnome/terminal/legacy/profiles:/ >"$2"

