#!/bin/bash -e

apk add --update --no-cache starship github-cli fish ruby cargo sccache
RUSTC_WRAPPER="" cargo install git-ai
git submodule update --init --recursive
pip3 install dotbot --break-system-packages
cp dotbot/tools/git-submodule/install dotbot
./dotbot -c install.conf.yaml
cd autojump && ./install.py
