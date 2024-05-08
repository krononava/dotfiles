#!/bin/bash

source $HOME/dotfiles/install-logic/check-existence.sh

link_file() {
    dotfile="$1"
    sourcepath="$2"
    sourcefile="$2$1"
    destinationpath="$3"
    destinationfile="$3$1"


    # check if personal config file exist
    check_file_existence "$sourcefile"
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


    # check if config file link already exist
    check_symlink_existence "$destinationfile"
    destinationfileexist=$?

    if [ $destinationfileexist -eq 1 ]; then
        echo -e "Symbolically linking $dotfile to its config directory\n"
        ln -s "$sourcefile" "$destinationpath"
    else
        echo -e "$dotfile already exist at $destinationpath"
        echo -e "Delete the existing $dotfile to proceed\n"
    fi

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
