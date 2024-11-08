#!/bin/bash

# Install necessary packages
sudo apt-get update
sudo apt-get install -y zsh curl git python3-pip zsh autojump vim

# Install Python packages
pip3 install dotbot

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Starship
curl -sS https://starship.rs/install.sh | sh -s -- --yes

dotbot -c install.conf.yaml
