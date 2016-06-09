# Dotfiles

## Install

``` bash
git clone https://github.com/oleander/dotfiles ~/.dotfiles

brew install vcprompt

ln -s ~/.dotfiles/gemrc ~/.gemrc
ln -s ~/.dotfiles/gitignore ~/.gitignore
ln -s ~/.dotfiles/gvimrc ~/.gvimrc
ln -s ~/.dotfiles/irbrc ~/.irbrc
ln -s ~/.dotfiles/tmuxrc ~/.tmuxrc
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/zshrc ~/.zshrc
ln -s ~/.dotfiles/gitconfig ~/.gitconfig

ln -s ~/.dotfiles/atom/config.cson ~/.atom/config.cson
ln -s ~/.dotfiles/atom/init.coffee ~/.atom/init.coffee
ln -s ~/.dotfiles/atom/keymap.cson ~/.atom/keymap.cson
ln -s ~/.dotfiles/atom/packages.cson ~/.atom/packages.cson
ln -s ~/.dotfiles/atom/snippets.cson ~/.atom/snippets.cson
ln -s ~/.dotfiles/atom/styles.less ~/.atom/styles.less

git clone https://github.com/robbyrussell/oh-my-zsh.git ~./oh-my-zsh
```

Load `~/.dotfiles` into iTerm2.