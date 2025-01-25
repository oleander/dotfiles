#!/usr/bin/env fish

set DOTFILES_DIR /share/.dotfiles
set DOTBOT_CONFIG install.conf.yaml

cd $DOTFILES_DIR

git submodule update --init --recursive

pip3 install --user dotbot

dotbot -c $DOTBOT_CONFIG

cd ./autojump
./install.py
cd $DOTFILES_DIR

set -e RUSTC_WRAPPER
apk add --update cargo
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
cargo binstall git-ai
