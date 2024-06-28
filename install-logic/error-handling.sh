#!/bin/bash

check_file_existence() {
    if [ -f "$1" ]; then
        return 0  # True, file exists
    else
        return 1  # False, file does not exist
    fi
}

check_symlink_existence() {
    if [ -L "$1" ]; then
        return 0  # True, file exists
    else
        return 1  # False, file does not exist
    fi
}


check_directory_existence() {
    if [ -d "$1" ]; then
        return 0  # True, file exists
    else
        return 1  # False, file does not exist
    fi
}

check_any_existence() {
    if [ -e "$1" ]; then
        return 0  # True, file exists
    else
        return 1  # False, file does not exist
    fi
}

check_desktop_environment() {
    if [[ "$XDG_CURRENT_DESKTOP" == *"$1"* ]]; then
	echo -e "$1 Desktop Environment detected\n"
	return 0
    else
	echo -e "Not using $1 Desktop Environment\n"
	return 1
    fi
}
