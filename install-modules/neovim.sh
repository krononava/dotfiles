#!/bin/bash

source $HOME/dotfiles/install-logic/universal-install.sh

recursive_symlink "kickstart.nvim" "$HOME/dotfiles/" "$HOME/.config/nvim/"

add_line "export EDITOR=nvim" "$HOME/.bashrc"