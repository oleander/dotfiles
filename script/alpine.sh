#!/bin/bash -e

DOTFILES_DIR=/share/dotfiles

cd "$DOTFILES_DIR"

ln -fs "$DOTFILES_DIR" "$HOME/.dotfiles"
# rm -rf ~/.local
# rm -rf ~/.cargo
# rm -rf ~/.rustup

# echo "Updating submodules"
# git submodule update --init --recursive

# echo "Installing dotbot"
# export PATH="$HOME/.local/bin:$PATH"
# pip3 install --user dotbot
# dotbot -c install.conf.yaml

./install

zsh -i -c 'exit'

echo "Installing git-ai"
unset RUSTC_WRAPPER
export PATH="$HOME/.cargo/bin:$PATH"
apk add --update cargo
cargo install cargo-binstall
cargo binstall -y --targets x86_64-unknown-linux-musl git-ai

# echo "Installing autojump"
# cd ./autojump
# ./install.py
# cd "$DOTFILES_DIR"
