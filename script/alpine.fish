#!/usr/bin/env fish

function log
    echo "[(date '+%Y-%m-%dT%H:%M:%S%z')]: $argv"
end

# Variables
set DOTFILES_DIR /share/.dotfiles
set DOTBOT_CONFIG install.conf.yaml

cd $DOTFILES_DIR

# Configure git to use fast-forward only
git config pull.ff only

# Stash local changes if any
if not git diff-index --quiet HEAD --
    log "Stashing local changes..."
    git stash
end

# Pull latest changes
log "Pulling latest changes..."
git pull

# Sync and update submodules
log "Updating submodules..."
git submodule update --init --recursive

# Install dotbot if not already installed
if not type -q dotbot
    log "Installing Dotbot..."
    pip3 install --user dotbot
end

# Run Dotbot to install dotfiles
log "Running Dotbot..."
dotbot -c $DOTBOT_CONFIG

# Install autojump if submodule exists
if test -d ./autojump
    log "Installing autojump..."
    cd ./autojump
    ./install.py
    cd $DOTFILES_DIR
else
    log "Autojump submodule not found. Skipping..."
end

log "Installing git-ai..."
set -e RUSTC_WRAPPER

if not type -q cargo
    log "Installing cargo..."
    apk add --update cargo
end

log "Installing cargo-binstall..."
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

# Install git-ai using cargo binstall
if not type -q git-ai
    log "Installing git-ai via cargo binstall..."
    cargo binstall git-ai
end

log "All tasks completed successfully."
