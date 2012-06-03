. ~/.dotfiles/zsh/paths
. ~/.dotfiles/zsh/config
. ~/.dotfiles/zsh/aliases
. ~/.dotfiles/zsh/completion

# Navigate to project path
if [[ -s /Users/linus/Documents/Projekt ]] ; then cr ; fi

# Using ruby 1.9.2 as default
rvm use 1.9.2 > /dev/null