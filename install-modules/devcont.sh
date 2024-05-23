#!/bin/bash

source $HOME/dotfiles/install-logic/universal-install.sh

add_line "alias dcbuild 'docker compose build'" $HOME/.config/fish/config.fish
add_line "alias dcrun 'docker compose run'" $HOME/.config/fish/config.fish
add_line "alias cpdevcont 'cp -r $HOME/dotfiles/kickstart.nvim/devcont .; cd devcont'" $HOME/.config/fish/config.fish
