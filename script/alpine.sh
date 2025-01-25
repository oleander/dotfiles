#!/bin/bash -e

DOTFILES_DIR=/share/dotfiles

cd "$DOTFILES_DIR"

ln -fs "$DOTFILES_DIR" "$HOME/.dotfiles"

echo "Updating submodules"
git submodule update --init --recursive

echo "Installing dotbot"
export PATH="$HOME/.local/bin:$PATH"
pip3 install --user dotbot
dotbot -c install.conf.yaml

zsh -i -c 'exit'

echo "Installing git-ai"
unset RUSTC_WRAPPER
export PATH="$HOME/.cargo/bin:$PATH"
apk add --update cargo
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
cargo binstall -y git-ai

# .rustup
# .local
# .cargo

# echo "Installing autojump"
# cd ./autojump
# ./install.py
# cd "$DOTFILES_DIR"
