#!/bin/bash

source $HOME/dotfiles/install-logic/check-existence.sh

link_file() {
    dotfile="$1"
    sourcepath="$2"
    sourcefile="$2$1"
    destinationpath="$3"
    destinationfile="$3$1"


    # check if personal config file exist
    check_any_existence "$sourcefile"
    sourcefileexist=$?

    if [ $sourcefileexist -eq 1 ]; then
        echo -e "$sourcefile does not exist, create one first\n"
        return 1
    fi


    # check if destination folder exist, if not, create one
    check_directory_existence "$destinationpath"
    destinationexist=$?

    if [ $destinationexist -eq 1 ]; then
        echo -e "$destinationpath does not exist, creating one...\n"
        mkdir "$destinationpath"
    fi

    echo -e "Symbolically linking $dotfile to its config directory\n"
    ln -sf "$sourcefile" "$destinationpath"

    return 0
}

set_gnome_settings() {
    schema=$1
    key=$2
    value=$3

    check_desktop_environment "GNOME"
    gnomeexist=$?

    if [ $gnomeexist -eq 0 ]; then
        echo -e "Setting $value to $key ..."
        gsettings set "$schema" "$key" "$value"
    fi
}

add_line() {
    line="$1"
    file="$2"
    grep -qF -- "$line" "$file" || echo "$line" >> "$file"
}

recursive_symlink() {
    directory="$2$1"
    for filepath in "$directory"/*; do
        filename=$(basename "$filepath")
        link_file $filename "$directory/" $3
    done
}