[ -z "$ROOT" ] export ROOT=~/.dotfiles/current

. $ROOT/zsh/config
. $ROOT/zsh/paths
. $ROOT/zsh/aliases/base
. $ROOT/zsh/aliases/git
. $ROOT/zsh/aliases/ruby
. $ROOT/zsh/completion

[ -f ~/.rvm/scripts/rvm ] && . ~/.rvm/scripts/rvm