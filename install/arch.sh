#!/bin/sh

# Please upgrade system before
yaourt -Sy
sudo pacman -Sy

sudo pacman -S atom --no-confirm
yaourt -S sublime-text-dev --no-confirm

