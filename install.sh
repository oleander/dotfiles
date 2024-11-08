#!/bin/bash -e

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  chmod +x scripts/linux.sh
  ./scripts/linux.sh
  exit 0
fi

dotbot -c install.conf.yaml
