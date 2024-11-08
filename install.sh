#!/bin/bash -e

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  ./scripts/linux.sh
fi

zsh -c "source ~/.zshrc"
