#!/bin/bash

source $HOME/dotfiles/install-logic/error-handling.sh

symlink() {
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

recursive_symlink() {
    directory="$2$1"
    for filepath in "$directory"/*; do
        filename=$(basename "$filepath")
        symlink $filename "$directory/" $3
    done
}

add_line() {
    line="$1"
    file="$2"
    grep -qF -- "$line" "$file" || echo "$line" >> "$file"
}