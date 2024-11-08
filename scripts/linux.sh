#!/bin/bash -e

export TERM=xterm-256color

sudo apt-get update
sudo apt-get install -y zsh curl git autojump vim python3-pip
curl -sS https://starship.rs/install.sh | sh -s -- --yes
pip3 install dotbot
ln -s "$(pwd)" ~/.dotfiles
dotbot -c install.conf.yaml
