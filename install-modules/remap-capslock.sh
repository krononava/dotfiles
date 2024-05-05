#!/bin/bash

# Remap Caps Lock to Ctrl
if [ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]; then
    echo -e "GNOME Desktop Environment detected, using dconf to remap caps lock as ctrl\n"
    dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"
else
    echo -e "Not using GNOME Desktop Environment, unable to remap caps lock as ctrl\n"
fi
