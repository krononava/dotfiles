#!/bin/bash

# Gnome Terminal CSS customization
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
