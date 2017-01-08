#!/bin/sh

# System upgrade
sudo pacman -Syyu
sudo yaourt -Syua --devel

# Programs
sudo pacman -S atom --no-confirm
yaourt -S byobu
yaourt -S sublime-text-dev

# Extras
yaourt -S vim-plug-git
yaourt -S autoenv

# ElementaryOS-like notifications
cd /usr/local/bin
sudo git clone https://github.com/ihashacks/notifyosd.zsh

