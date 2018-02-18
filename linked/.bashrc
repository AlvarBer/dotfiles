# If not running interactively, don't do anything
if [[ $- != *i* ]] ; then  # Shell is non-interactive.  Be done now!
	return
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

###############################################################################
# Prompt & Colors

# set a fancy prompt (non-color, unless we know we "want" color)
if [[ $(tput colors) -gt 1 || $COLOUR == "yes" ]]; then
	export COLOUR=yes # This doesn't cover all cases, but what does?
	source ~/.colours.sh # Some Colours for convenience

	# Colored GCC warning and errors
	export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
	export TERM=screen-256color
else
	export COLOUR=no
fi

source ~/.bash_prompt

# Byobu Prompt in case we are in byobu
if [[ -r ~/.byobu/prompt ]]; then
	source ~/.byobu/prompt
fi

###############################################################################

# Alias definitions.
if [[ -f ~/.aliases.sh ]]; then
	source ~/.aliases.sh
fi

###############################################################################
# Auto Completion

# Enable programmable completion features (you don't need to enable this, if it
# is already enabled in /etc/bash.bashrc and /etc/profile sources that file).
if ! shopt -oq posix; then
	if [[ -f /usr/share/bash-completion/bash_completion ]]; then
		source /usr/share/bash-completion/bash_completion
	elif [[ -f /etc/bash_completion ]]; then
		source /etc/bash_completion
	fi
fi

# SSH auto-completion based on entries in known_hosts.
if [[ -e ~/.ssh/known_hosts ]]; then
	complete -o default -W "$(cat ~/.ssh/known_hosts | sed 's/[, ].*//' | sort | uniq | grep -v '[0-9]')" ssh scp sftp
fi

###############################################################################
# Autoenv Python virtualenv

if [ -e ~/.autoenv/activate.sh ]; then
	source ~/.autoenv/activate.sh
fi

###############################################################################
# Dotfiles synchronization

# Adds an entry to the PATH after trying to remove it, 
# as seen on http://stackoverflow.com/a/2108540/142339
TMP=:$PATH:
TMP=${TMP/:~/dotfiles/bin:/:}
TMP=${TMP%:}
TMP=${TMP#:}
PATH=$TMP
PATH=~/dotfiles/bin:$PATH

# Avoid ssh password every time
keychain $HOME/.ssh/id_rsa &>/dev/null
source $HOME/.keychain/$HOSTNAME-sh
