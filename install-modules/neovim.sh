#!/bin/bash

source error-handling/check-existence.sh

sourcepath="~/dotfiles/init.lua"
destinationpath="~/.config/nvim"

check-file-existence "$filepath"
sourceExist=$?

if [ $sourceExist -eq 1 ]; then
    echo -e "init.lua does not exist, create one first\n"
    exit
fi

## Make sure nvim config directory exist
if [ ! -e ~/.config/nvim ]; then
    echo -e "Creating nvim folder\n"
    mkdir ~/.config/nvim
fi
## Make sure nvim config symlink doesn't already exist
if [ ! -e ~/.config/nvim/init.lua ]; then
    echo -e "Symbolically linking init.lua to nvim config directory\n"
    ln -s ~/dotfiles/init.lua ~/.config/nvim/
else
    echo -e "init.lua already exist at destination"
    echo -e "Delete the existing init.lua to proceed\n"
fi
