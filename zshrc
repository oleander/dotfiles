. ~/.dotfiles/zsh/paths
. ~/.dotfiles/zsh/config
. ~/.dotfiles/zsh/aliases
. ~/.dotfiles/zsh/completion

 export SSL_CERT_FILE=/usr/local/etc/openssl/cacert.pem
# Navigate to project path
if [[ -s /Users/linus/Documents/Projekt ]] ; then cr ; fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
