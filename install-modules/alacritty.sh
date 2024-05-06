#!/bin/bash

source install-logic/check-existence.sh
source install-logic/universal-install.sh

check_desktop_environment "GNOME"
gnomeexist=$?

if [ gnomeexist -eq 0 ]; then
    echo -e "Using gsettings to set alacritty as default terminal\n"
    gsettings set org.gnome.desktop.default-applications.terminal exec alacritty
else
    echo -e "Unable to set alacritty as default terminal\n"
fi

file-link "alacritty.toml" "~/dotfiles/" "~/.config/alacritty/"
