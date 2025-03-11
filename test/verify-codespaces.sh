#!/usr/bin/env bash
set -e

# Colors for better readability
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

cd "$(dirname "$0")/.."
DOTFILES_DIR="$(pwd)"

echo -e "${YELLOW}Starting test for GitHub Codespaces environment...${NC}"

# Function to check if a command succeeded
check_success() {
  if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ $1${NC}"
  else
    echo -e "${RED}✗ $1${NC}"
    exit 1
  fi
}

# Make sure we're in a clean environment
if [ -f ~/.zshrc.bak ]; then
  mv ~/.zshrc.bak ~/.zshrc
fi

# Backup existing zshrc if any
if [ -f ~/.zshrc ]; then
  cp ~/.zshrc ~/.zshrc.bak
fi

echo -e "${YELLOW}1. Running installation script with GitHub configuration...${NC}"
./install -c install-github.conf.yaml
check_success "Installation completed"

echo -e "${YELLOW}2. Testing if compinit runs without prompting...${NC}"
# This should run without prompting for input
ZSH_DISABLE_COMPFIX=true zsh -c "autoload -Uz compinit && compinit -u"
check_success "Compinit runs without prompting"

echo -e "${YELLOW}3. Verifying autojump installation...${NC}"
if [ -f ~/.autojump/bin/autojump ]; then
  echo -e "${GREEN}✓ Autojump binary found${NC}"
else
  # Try to find autojump in other locations
  AUTOJUMP_PATH=$(find ~ -name autojump -type f | head -1)
  if [ -n "$AUTOJUMP_PATH" ]; then
    echo -e "${YELLOW}! Autojump found at alternate location: $AUTOJUMP_PATH${NC}"
  else
    echo -e "${RED}✗ Autojump binary not found${NC}"
    exit 1
  fi
fi

echo -e "${YELLOW}4. Testing all scripts in inst/github...${NC}"
for script in $(find "$DOTFILES_DIR/inst/github" -type f); do
  SCRIPT_NAME=$(basename "$script")
  echo -e "${YELLOW}Testing $SCRIPT_NAME...${NC}"
  
  # Make sure the script is executable
  chmod +x "$script"
  
  # Check if the binary exists in ~/.local/bin
  if [ -f ~/.local/bin/inst-"$SCRIPT_NAME" ]; then
    echo -e "${GREEN}✓ Binary inst-$SCRIPT_NAME exists${NC}"
  else
    echo -e "${RED}✗ Binary inst-$SCRIPT_NAME not found${NC}"
    exit 1
  fi
done

echo -e "${YELLOW}5. Testing if zshrc.github is correctly sourced...${NC}"
if grep -q "source ~/.zshrc.github" ~/.zshrc; then
  echo -e "${GREEN}✓ zshrc.github is sourced in .zshrc${NC}"
else
  echo -e "${RED}✗ zshrc.github is not sourced in .zshrc${NC}"
  exit 1
fi

echo -e "${GREEN}All tests passed successfully!${NC}"

# Restore original zshrc if it existed
if [ -f ~/.zshrc.bak ]; then
  mv ~/.zshrc.bak ~/.zshrc
fi