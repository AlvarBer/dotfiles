dotfiles
========
A minimal dotfiles system inspired by [cowboy dotfiles].

Mainly done for learning purposes, it might kill your dotfiles.

It should work on most mayor Linux distros.

backup folder
-------------
Folder which fills up when a synchronization happens and there is a clash.

bin folder
----------
All files here are considered executables.

`dotfiles.sh` is where the main synchronization happens.

This whole folder should be sourced in your *bashrc*, *zshrc*, etc...

install folder
--------------
This folder is only executed the first time, it performs the installation of 
the programs you want if the distro you are on is named as one of the scripts.

linked folder
-------------
Everything here (files & folders) is (hard)linked into ~



[cowboy dotfiles]: https://github.com/cowboy/dotfiles
