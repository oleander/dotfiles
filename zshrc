. ~/.dotfiles/zsh/paths
. ~/.dotfiles/zsh/config
. ~/.dotfiles/zsh/aliases/base
. ~/.dotfiles/zsh/aliases/git
. ~/.dotfiles/zsh/aliases/rails
. ~/.dotfiles/zsh/aliases/ruby
. ~/.dotfiles/zsh/completion

export SSL_CERT_FILE=/usr/local/etc/openssl/cacert.pem

# # Navigate to project path
# if [[ -s /Users/linus/Documents/Projekt ]] ; then cr ; fi

export JAVA_HOME="/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home/"

# Add GHC 7.8.4 to the PATH, via http://ghcformacosx.github.io/
export GHC_DOT_APP="/Applications/ghc-7.8.4.app"
if [ -d "$GHC_DOT_APP" ]; then
    export PATH="${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi