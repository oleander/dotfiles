#!/bin/bash -e

DOTFILES_DIR=/share/.dotfiles

cd "$DOTFILES_DIR"

echo "Updating submodules"
git submodule update --init --recursive

echo "Installing dotbot"
export PATH="$HOME/.local/bin:$PATH"
pip3 install --user dotbot
dotbot -c install.conf.yaml

echo "Installing git-ai"
unset RUSTC_WRAPPER
export PATH="$HOME/.cargo/bin:$PATH"
apk add --update cargo
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
cargo binstall git-ai

echo "Installing autojump"
cd ./autojump
./install.py
cd "$DOTFILES_DIR"
