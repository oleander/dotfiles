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
ln -fs ~/.dotfiles/hushlogin ~/.hushlogin

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
```

Load `~/.dotfiles` into iTerm2.

## Custom configs

Place the custom, host specific script in `zsh/profiles` and will be loaded automatically.