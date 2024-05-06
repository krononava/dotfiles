#!/bin/bash

source $HOME/dotfiles/install-logic/universal-install.sh

link_file "init.lua" "$HOME/dotfiles/" "$HOME/.config/nvim/"

set_default_editor "nvim"