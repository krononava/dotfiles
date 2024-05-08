#!/bin/bash

source $HOME/dotfiles/install-logic/universal-install.sh

link_file "init.lua" "$HOME/dotfiles/" "$HOME/.config/nvim/"

add_line "export EDITOR=nvim" "$HOME/.bashrc"
