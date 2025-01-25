#!/bin/bash -e

unset RUSTC_WRAPPER

# cargo install git-ai

cd /share/.dotfiles
git config pull.ff only
git stash
git pull
git submodule sync
git submodule update --init --recursive
pip3 install dotbot --break-system-packages
dotbot -c install.conf.yaml
zsh --login || true
cd /share/.dotfiles/autojump
./install.py
