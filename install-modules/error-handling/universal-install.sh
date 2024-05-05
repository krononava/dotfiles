#!/bin/bash

source check-existence.sh

full-check() {
    dotfile="$1"
    sourcepath="$2"
    sourcefile="$2$1"
    destinationpath="$3"
    destinationfile="$3$1"


    # check if personal config file exist
    check-file-existence "$sourcefile"
    sourcefileexist=$?

    if [ $sourcefileexist -eq 1 ]; then
	echo -e "$sourcefile does not exist, create one first\n"
	return 1
    fi


    # check if destination folder exist, if not, create one
    check-directory-existence "$destinationpath"
    destinationexist=$?

    if [ $destinationexist -eq 1 ]; then
	echo -e "$destinationpath does not exist, creating one...\n"
	mkdir "$destinationpath"
    fi


    # check if config file link already exist
    check-symlink-exist "$destinationfile"
    destinationfileexist=$?

    if [ destinationfileexist -eq 1 ]; then
	echo -e "Symbolically linking init.lua to nvim config directory\n"
	ln -s ~/dotfiles/init.lua ~/.config/nvim/
    else
	echo -e "init.lua already exist at destination"
	echo -e "Delete the existing init.lua to proceed\n"
    fi

    return 0
}
