#!/usr/local/bin/zsh

set -e

# Uninstall
# rvm implode

# Install rvm
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash
source ~/.zshrc

# Install ruby
rvm install ruby-2.3.0
rvm install ruby-2.2.4

# Setup
rvm use 2.3.0 --default
gem install bundler

# Install deps
for gemfile in $(find ~/Documents/Projekt -maxdepth 2 -name "Gemfile"); do
  cd $(dirname $gemfile) && bundle install 2>&1
done
