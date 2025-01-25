#!/bin/bash -e

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

unset RUSTC_WRAPPER
apk add --update cargo
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
cargo binstall git-ai
