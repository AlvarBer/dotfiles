#!/bin/sh

# Please upgrade system before
yaourt -Sy
sudo pacman -Sy

sudo pacman -S atom --no-confirm
yaourt -S sublime-text-dev --no-confirm

cd /usr/local/bin
sudo git clone https://github.com/ihashacks/notifyosd.zsh
