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

git clone https://github.com/robbyrussell/oh-my-zsh.git ~./oh-my-zsh
```

Load `~/.dotfiles` into iTerm2.

## Custom configs

Rename `config.example` to `config` and add your custom aliases.