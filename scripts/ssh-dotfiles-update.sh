#!/bin/bash

# Script to update dotfiles on remote hosts when connecting via SSH
# Called from SSH config LocalCommand

if which git >/dev/null 2>&1; then
  if [[ -d ~/dotfiles ]]; then
    echo "Updating dotfiles..."
    cd ~/dotfiles && \
    git -c gc.auto=0 -c protocol.version=2 -c http.timeout=10 -c core.askPass=true stash -q >/dev/null 2>&1 && \
    git -c gc.auto=0 -c protocol.version=2 -c http.timeout=10 -c pull.timeout=10 pull --quiet >/dev/null 2>&1 && \
    echo "Done" || echo "Failed"

    [[ -f ./install ]] && ./install >/dev/null 2>&1
  else
    echo "Installing dotfiles..."
    git -c gc.auto=0 -c protocol.version=2 -c http.timeout=10 -c clone.timeout=10 clone --quiet https://github.com/oleander/dotfiles >/dev/null 2>&1 && \
    ./dotfiles/install >/dev/null 2>&1 && \
    echo "Done"
  fi
fi
