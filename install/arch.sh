#!/bin/sh

# Please upgrade system before
yaourt -Syyu
sudo pacman -Syyu

sudo pacman -S atom --no-confirm
yaourt -S sublime-text-dev --no-confirm
yaourt -S vim-plug-git --no-confirm

cd /usr/local/bin
sudo git clone https://github.com/ihashacks/notifyosd.zsh
