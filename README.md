dotfiles
========
A dotfiles system inspired by [cowboy dotfiles].

Come where the magic happens.

backup folder
-------------
Folder which fills up when a synchronization happens and there is a clash.

bin folder
----------
All files are considered executables.

`dotfiles.sh` is where the main synchronization happens.

This whole folder should be sourced in your *bashrc*, *zshrc*, etc...

install folder
--------------
This folder is only executed the first time, it performs the installation of 
the programs you want if the distro you are on is named as one of the scripts.

linked folder
-------------
Everything here (files & folders) is sourced into ~


[cowboy dotfiles]: https://github.com/cowboy/dotfiles
