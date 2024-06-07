#!/bin/bash

if [[ $1 == *"coder"* ]]; then
    docker build --target $1 -t project .
    docker run -it --network=host -v "$PWD:/home/coder/project" project
elif [[ $1 == *"jupyter"* ]]; then
    docker build --target $1 -t project .
    docker run --rm --network=host -v .:/home/jovyan/work fpp start-notebook.py --NotebookApp.token=''
else
    cp -r $HOME/dotfiles/kickstart.nvim .
    docker build --target $1 -t project .
    rm -r kickstart.nvim
    docker run -it -v .:/workspace project
fi
