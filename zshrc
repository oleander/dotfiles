. ~/.dotfiles/zsh/paths
. ~/.dotfiles/zsh/config
. ~/.dotfiles/zsh/aliases

# Navigate to project path
if [[ -s /Users/linus/Documents/Projekt ]] ; then cr ; fi

# Using ruby 1.9.2 as default
rvm use 1.9.2 > /dev/null
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
