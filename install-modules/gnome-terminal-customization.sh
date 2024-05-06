#!/bin/bash

source $HOME/dotfiles/install-logic/universal-install.sh

link_file "gtk.css" "$HOME/dotfiles/" "$HOME/.config/gtk3.0/"

echo -e "Restarting gnome terminal\n"
pkill gnome-terminal