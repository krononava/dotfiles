#!/bin/bash

# Check dotfiles directory
parent_dir=$(dirname "$(realpath "$0")")
if [ ! $parent_dir = ~/dotfiles ]; then
    echo -e "dotfiles directory must be in home directory\n"
    exit
fi


# Configure neovim setup
## Make sure nvim config exist
if [ ! -f init.lua ]; then
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


# Add padding to gnome terminal
## Make sure gtk css config exist
if [ ! -f gtk.css ]; then
    echo -e "gtk.css does not exist, create one first\n"
    exit
fi
## Make sure gtk-3.0 directory exist
if [ ! -e ~/.config/gtk-3.0 ]; then
    echo -e "GTK 3.0 does not exist"
    echo -e "Aborting...\n"
    exit
fi
if [ ! -e ~/.config/gtk-3.0/gtk.css ]; then
    echo -e "Symbolically linking gtk.css to gtk config directory\n"
    ln -s ~/dotfiles/gtk.css ~/.config/gtk-3.0/gtk.css
    echo -e "Restarting gnome terminal\n"
    sleep 2
    pkill gnome-terminal
else
    echo -e "gtk.css already exist at destination"
    echo -e "Delete the existing gtk.css to proceed\n"
fi

if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
    echo -e "GNOME Desktop Environment detected, using dconf to remap caps lock as ctrl\n"
    dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"
fi
