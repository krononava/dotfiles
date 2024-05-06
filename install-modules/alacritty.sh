#!/bin/bash

source $HOME/dotfiles/install-logic/universal-install.sh

set_gnome_settings "org.gnome.desktop.default-applications.terminal" "exec" "alacritty"

link_file "alacritty.toml" "$HOME/dotfiles/" "$HOME/.config/alacritty/"