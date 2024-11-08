#!/bin/bash -e

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  ./scripts/linux.sh
fi

dotbot -c install.conf.yaml
source "$HOME/.zshrc"
