#!/bin/bash

source $HOME/dotfiles/install-logic/universal-install.sh

add_line "XKBOPTIONS=\"ctrl:nocaps\"" "/etc/default/keyboard"
