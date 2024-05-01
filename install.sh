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
## Make sure gtk.css symlink doesn't already exist
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

# Remap Caps Lock to Ctrl
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
    echo -e "GNOME Desktop Environment detected, using dconf to remap caps lock as ctrl\n"
    dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"
fi

# Set Neovim as default editor
## Define the lines to be added
line1="export EDITOR=nvim"
## Path to the .bashrc file
bashrc="$HOME/.bashrc"
## Function to append a line if it does not exist
append_line() {
    local line="$1"
    local file="$2"
    grep -qF -- "$line" "$file" || echo "$line" >> "$file"
}
## Append lines to .bashrc if they do not exist
append_line "$line1" "$bashrc"
echo "Neovim is now the default editor in terminal"
