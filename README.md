# Dotfiles

## Install

``` bash
git clone https://github.com/oleander/dotfiles ~/.dotfiles

brew install vcprompt

ln -fs ~/.dotfiles/gemrc ~/.gemrc
ln -fs ~/.dotfiles/gitignore ~/.gitignore
ln -fs ~/.dotfiles/gvimrc ~/.gvimrc
ln -fs ~/.dotfiles/irbrc ~/.irbrc
ln -fs ~/.dotfiles/tmuxrc ~/.tmuxrc
ln -fs ~/.dotfiles/vimrc ~/.vimrc
ln -fs ~/.dotfiles/zshrc ~/.zshrc
ln -fs ~/.dotfiles/gitconfig ~/.gitconfig

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
```

Load `~/.dotfiles` into iTerm2.

## Custom configs

Rename `config.example` to `config` and add your custom aliases.