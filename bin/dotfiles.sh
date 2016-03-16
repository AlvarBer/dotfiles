#!/bin/env bash

dotfiles() {
	origin=https://github.com/AlvarBer/tempdotfiles.git
	cd ~
	if [ -z type -p git ] ; then
		sudo apt-get install git
	fi
	if [ ! -d dotfiles ] ; then
		git clone origin dotfiles
		mkdir dotfiles/backup
	else
		git fetch origin master
		if [ git rev-parse @ == git rev-parse @{u} ]; then
			exit 0
		git pull origin master
	fi
	cd dotfiles/linked
	for file in find . -maxdepth 1 -mindepth 1 -name * ; do
		ln -s `pwd`/$file ~/$file
		if [ $? -eq 1 ] ; then
			echo 'File already exists in ~, moving it to backup'
			mv ~/$file ~/dotfiles/backup
			ln -s `pwd`/$file ~/$file
		fi
	done
}