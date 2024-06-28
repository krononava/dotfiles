#!/bin/bash

source $HOME/dotfiles/install-logic/universal-install.sh

symlink "default.conf" "$HOME/dotfiles/" "/etc/keyd/"
