#!/bin/bash -e

# Ensure the dotfiles directory exists
cd /share/.dotfiles

# Ensures changes are stashed before pulling new changes
git config pull.ff only
git stash
git pull

# Sync and update submodules
# Do we need both?
git submodule sync
git submodule update --init --recursive

# Install dotbot and run the install script to distribute the dotfiles
pip3 install dotbot --break-system-packages
dotbot -c install.conf.yaml

# Install autojump (submodule)
cd ./autojump
./install.py

# Refresh the shell to install zsh packages
# Does not work
zsh --login || true

# Install git-ai
unset RUSTC_WRAPPER
apk add --update cargo
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
cargo binstall git-ai
