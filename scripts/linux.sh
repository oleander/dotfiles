#!/bin/bash

# Update packages
apt-get update

# Install Zsh and set it as the default shell
apt-get install -y zsh
# chsh -s $(which zsh)

# Install curl and Starship prompt
apt-get install -y curl
curl -sS https://starship.rs/install.sh | sh -s -- --yes

# Download Antigen for Zsh
curl -L git.io/antigen >~/.antigen.zsh

# Install additional packages
apt-get install -y git autojump vim

# Install dotbot
pip3 install dotbot

# Run dotbot installation
dotbot -c install.conf.yaml

# Source the Zsh configuration
zsh -c "source ~/.zshrc"
