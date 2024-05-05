#!/bin/bash

# Change ttl to bypass wifi hotspot
if [ ! -e /etc/sysctl.d/10-change-ttl.conf ]; then
    echo -e "Symbolically linking 10-change-ttl.conf to sysctl directory\n"
    ln -s ~/dotfiles/10-change-ttl.conf /etc/sysctl.d/10-change-ttl.conf
else
    echo -e "ttl config already exist at destination"
    echo -e "Delete the existing 10-change-ttl.conf to proceed\n"
fi
