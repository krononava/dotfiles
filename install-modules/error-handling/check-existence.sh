#!/bin/bash

path="$1"

check_file_existence() {
    if [ -f "$path" ]; then
        return 0  # True, file exists
    else
        return 1  # False, file does not exist
    fi
}

check_symlink_existence() {
    if [ -L "$path" ]; then
        return 0  # True, file exists
    else
        return 1  # False, file does not exist
    fi
}


check_directory_existence() {
    if [ -d "$path" ]; then
        return 0  # True, file exists
    else
        return 1  # False, file does not exist
    fi
}

check_any_existence() {
    if test -e "$path"; then
        return 0  # True, file exists
    else
        return 1  # False, file does not exist
    fi
}

