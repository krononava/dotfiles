#!/bin/bash


# Check dotfiles directory
parent_dir=$(dirname "$(realpath "$0")")
if [ ! $parent_dir = $HOME/dotfiles ]; then
    echo -e "dotfiles directory must be in $HOME\n"
    exit
fi

# Directory containing the scripts
SCRIPT_DIR=$HOME/dotfiles/install-modules

# Loop through each file in the directory
for script in "$SCRIPT_DIR"/*.sh; do
    # Check if the file is executable
    if [ -x "$script" ]; then
        echo "Running $script..."
        # Execute the script
        "$script"
    else
        echo "Skipping $script, not executable..."
    fi
done
