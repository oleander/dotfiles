#!/bin/bash -e

ggg || true
gp || true
ssh homeassistant -p 2222 -- ha addons restart a0d7b954_ssh
ssh homeassistant -p 2222 -- ha addons logs a0d7b954_ssh -f
