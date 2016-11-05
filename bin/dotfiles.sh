#!/bin/sh

# Here we syncronize/pull all files and link them
synchronize() {
	NAME=AlvarBer
	WEBSITE=github.com
	remoteurl=https://${NAME}@${WEBSITE}/${NAME}/dotfiles.git
	#sshurl=git@${WEBSITE}:${NAME}/dotfiles.git
	
	cd ~
	if ! git --version >/dev/null 2>&1; then
		echo git is not installed, install it and try again 2>&1
		exit 1
	fi
	if [ ! -d dotfiles ]; then
		echo Cloning dotfiles repo
		git clone $remoteurl dotfiles
		#git remote set-url origin sshurl
		
		cd dotfiles && mkdir backup
		if [ "$(id -u)" = 0 ]; then  # Checking for sudo
			get_distro
			if [ ! -z "$DISTRIB_ID" ]; then  # Checking distro
				install/"${DISTRIB_ID}".sh
			else
				echo Your distro has not install script 2>&1
			fi
		else
			echo You need sudo to run install script 2>&1
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
				echo File "$file" already in ~, backing up
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
				echo Dir "$dir" already in ~, backing up
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
			echo Could not determine distro 2>&1
			DISTRIB_ID=
		fi
	fi
}

add() {
	for file in "$@"; do
		mv "$(pwd)"/"$file" ~/dotfiles
		ln -ns dotfiles/"$file" ~/linked
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

