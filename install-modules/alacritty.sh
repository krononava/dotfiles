#!/bin/bash

# Set Alacritty as the default terminal
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
    echo -e "GNOME Desktop Environment detected, using gsettings to set alacritty as default terminal\n"
    gsettings set org.gnome.desktop.default-applications.terminal exec alacritty
else
    echo -e "Not using GNOME Desktop Environment, unable to set alacritty as default terminal\n"
fi

# Make sure alacrity config folder exist
if [ ! -e ~/.config/alacritty ]; then
    mkdir ~/.config/alacritty
fi

if [ ! -e ~/.config/alacritty/alacritty.toml ]; then
    echo -e "Symbolic linking alacritty.toml to alacritty config directory\n"
    ln -s ~/dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml
else
    echo -e "alacritty.toml already exist at ~/.config/alacritty/, delete it to continue"
fi
