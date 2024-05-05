#!/bin/bash

# Set Neovim as default editor
## Define the lines to be added
line1="export EDITOR=nvim"
## Path to the .bashrc file
bashrc="$HOME/.bashrc"
## Function to append a line if it does not exist
append_line() {
    local line="$1"
    local file="$2"
    grep -qF -- "$line" "$file" || echo "$line" >> "$file"
}
## Append lines to .bashrc if they do not exist
append_line "$line1" "$bashrc"
echo "Neovim is now the default editor in terminal"
