#!/bin/bash

source $HOME/dotfiles/install-logic/universal-install.sh

recursive_symlink "qutebrowser" "$HOME/dotfiles/" "$HOME/.config/qutebrowser"
