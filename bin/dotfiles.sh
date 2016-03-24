#!/bin/bash

# Here we syncronize / pull al files and link them
dotfiles() {
	githuburl=https://AlvarBer@github.com/AlvarBer/dotfiles.git
	sshurl=git@github.com:AlvarBer/dotfiles.git
	cd ~
	if [[ ! "$(type -P git)" ]] ; then
		echo "Installing git"
		sudo apt-get install git
	fi
	if [[ ! -d dotfiles ]] ; then
		git clone $githuburl dotfiles
		#git remote set-url origin sshurl
		cd dotfiles
		mkdir backup
		add_to_path ~/dotfiles/bin
	else
		cd dotfiles
		git fetch origin master
		if [[ '$(git rev-parse @)' = '$(git rev-parse @{u})' ]] ; then
			exit 0 # This conditionals checks for updates in the remote
		fi
		git merge origin/master
	fi
	cd linked
	for file in $(find . -maxdepth 1 -mindepth 1 -name * -type f) ; do
		ln -s `pwd`/$file ~/$file # File Soft Linking
		if [[ $? -eq 1 ]] ; then
			echo 'File already exists in ~, moving it to backup'
			mv ~/$file ~/dotfiles/backup
			ln -s `pwd`/$file ~/$file
		fi
	done
	for dir in $(find . -maxdepth 1 -mindepth 1 -name * -type d) ; do
		ln -s `pwd`/$dir ~/$dir # Directories Soft Linking
		if [[ $? -eq 1 ]] ; then
			echo 'Dir already exists in ~, doing something'
			mv ~/$dir ~/tmp
			ln -s `pwd`/$dir ~/$dir
			mv -n ~/tmp/* ~/$dir
			rm -rf ~/tmp
		fi
	done
}

# Adds an entry to the PATH after trying to remove it, 
# as seen on http://stackoverflow.com/a/2108540/142339
add_to_path() {
	TMP=:$PATH:
	REMOVE=$1
	TMP=${TMP/:$REMOVE:/:}
	TMP=${TMP%:}
	TMP=${TMP#:}
	PATH=$TMP
	PATH=~/dotfiles/bin:$PATH
}

get_distro() {
	if [[ -z DISTRIB_ID ]]; then
		. /etc/lsb-release
	fi
}

dotfiles "$@"
