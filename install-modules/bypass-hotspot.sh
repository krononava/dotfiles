#!/bin/bash

source $HOME/dotfiles/install-logic/universal-install.sh

link_file "10-change-ttl.conf" "$HOME/dotfiles/" "/etc/sysctl.d/"