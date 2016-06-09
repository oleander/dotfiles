[ -f ~/.dotfiles/config ] && . ~/.dotfiles/config || echo "Config file not found"
. ~/.dotfiles/zsh/oh-my
. ~/.dotfiles/zsh/config
. ~/.dotfiles/zsh/paths
. ~/.dotfiles/zsh/aliases/base
. ~/.dotfiles/zsh/aliases/git
. ~/.dotfiles/zsh/aliases/ruby
. ~/.dotfiles/zsh/completion