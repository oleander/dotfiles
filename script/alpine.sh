#!/bin/bash -e

FROM alpine

apk add --update git make clang ruby ruby-irb ncurses-dev tar binutils build-base bash perl zlib zlib-dev jq patch
mkdir /brew && chown nobody:users /brew
git clone https://github.com/Homebrew/linuxbrew.git /brew
cp -r /brew/bin/ /brew/orig_bin/

apk add --update --no-cache starship github-cli fish ruby cargo sccache
RUSTC_WRAPPER="" cargo install git-ai
git submodule update --init --recursive
pip3 install dotbot --break-system-packages
cp dotbot/tools/git-submodule/install dotbot
./dotbot -c install.conf.yaml
cd autojump && ./install.py || true
