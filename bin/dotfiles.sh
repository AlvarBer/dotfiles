#!/bin/sh

# Here we syncronize/pull all files and link them
synchronize() {
	NAME=AlvarBer
	WEBSITE=github.com
	remoteurl=https://${NAME}@${WEBSITE}/${NAME}/dotfiles.git
	#sshurl=git@${WEBSITE}:${NAME}/dotfiles.git
	
	get_distro

	cd ~
	if ! git --version >/dev/null 2>&1; then
		echo git is not installed, install it and try again
		exit 1
	fi
	if [ ! -d dotfiles ]; then
		echo Cloning dotfiles repo
		git clone $remoteurl dotfiles
		#git remote set-url origin sshurl
		
		cd dotfiles
		mkdir backup
		if [ "$(whoami)" = "root" ] && [ ! -z "$DISTRIB_ID" ]; then 
			install/"${DISTRIB_ID}".sh
		else
			echo You need sudo to install the programs or your distro has not a install script
		fi
	else
		cd dotfiles
		git fetch origin master
		if [ "$(git rev-parse @)" = "$(git rev-parse @{u})" ]; then
			echo No new changes in dotfiles upstream
			exit 0
		fi
		git merge origin/master
	fi
	cd linked
	for file in $(find . -maxdepth 1 -mindepth 1 -name * -type f); do
		if [ -f ~/"$file" ]; then
			if [ "$1" = "-v" ]; then
				printf "File %s already exists in ~, backing up\n" "$file"
			fi
			mv -f ~/"$file" ~/dotfiles/backup
			ln -s "$(pwd)"/"$file" ~
		else
			ln -s "$(pwd)"/"$file" ~
		fi
	done
	for dir in $(find . -maxdepth 1 -mindepth 1 -name * -type d); do
		if [ -d ~/"$dir" ]; then
			if [ "$1" = "-v" ]; then
				printf "Dir %s already in ~, preserving content\n" "$dir"
			fi
			mkdir ~/tmp
			mv ~/"$dir"/* ~/tmp
			rm -d ~/"$dir"
			ln -s "$(pwd)"/"$dir" ~
			mv -n ~/tmp/* ~/"$dir"
			rm -rf ~/tmp
		else
			ln -s "$(pwd)"/"$dir" ~
		fi
	done
}

# This gets the distro name (If possible)
get_distro() {
	if [ -z "$DISTRIB_ID" ]; then
		if [ -f /etc/lsb-release ]; then
			. /etc/lsb-release
		else
			echo Could not determine distro
			DISTRIB_ID=
		fi
	fi
}

add() {
	for file in "$@"; do
		mv "$file" ~/dotfiles
		ln -s dotfiles/"$file" ~/linked
	done
}

# Script itself
set -eo pipefail
case $1 in
	add)
		shift
		add "$@";;
	unlink)
		echo Pending functionality;;
	*)
		synchronize "$@";;
esac

