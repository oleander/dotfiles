#!/bin/bash -e

DOTFILES_DIR=/share/dotfiles

cd "$DOTFILES_DIR"

./install

echo "Installing git-ai"
unset RUSTC_WRAPPER
export PATH="$HOME/.cargo/bin:$PATH"
apk add --update cargo
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
cargo binstall -y --targets x86_64-unknown-linux-musl git-ai

echo "Installing autojump"
git clone https://github.com/wting/autojump.git /tmp/autojump
cd /tmp/autojump
chmod +x ./install.py
export SHELL=/bin/zsh
./install.py
cd "$DOTFILES_DIR"
