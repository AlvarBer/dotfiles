source /usr/share/zsh/site-contrib/powerline.zsh

# Source handy aliases
source ~/.aliases.sh
# And cool colors
source ~/.colours.sh

# Exporting variables
export TERM=screen-256color
export JAVA_HOME=/usr/bin/java
export EDITOR=nvim

# Autocompletion
zstyle ':completion:*' menu select
autoload compinit
autoload bashcompinit
compinit
bashcompinit
eval "$(pandoc --bash-completion)"

# Add dotfiles binary folder to path if not already on it
export PATH=~/dotfiles/bin:$PATH


