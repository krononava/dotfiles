#!/bin/bash

source $HOME/dotfiles/install-logic/universal-install.sh

add_line "alias dcb 'docker compose build'" $HOME/.config/fish/config.fish
add_line "alias dcr 'docker compose run default'" $HOME/.config/fish/config.fish
