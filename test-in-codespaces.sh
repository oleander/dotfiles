#!/usr/bin/env bash

# Colors for better readability
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Testing dotfiles in simulated GitHub Codespaces environment...${NC}"

# Make sure everything is executable
chmod +x ./install
chmod +x ./test/verify-codespaces.sh
if [ -d ./inst/github ]; then
  chmod +x ./inst/github/*
fi

# Check if dip is installed
if ! command -v dip &> /dev/null; then
  echo -e "${RED}dip is not installed. Installing it now...${NC}"
  if command -v gem &> /dev/null; then
    gem install dip
  else
    echo -e "${RED}Ruby gem command not found. Please install Ruby and run 'gem install dip'.${NC}"
    exit 1
  fi
fi

# Run the tests using dip
echo -e "${YELLOW}Step 1: Running dotfiles installation in Codespaces container...${NC}"
dip install-codespaces

# Check exit status
if [ $? -eq 0 ]; then
  echo -e "${GREEN}✓ Installation successful${NC}"
else
  echo -e "${RED}✗ Installation failed${NC}"
  exit 1
fi

echo -e "${YELLOW}Step 2: Verifying the installation...${NC}"
dip verify-codespaces

# Check exit status
if [ $? -eq 0 ]; then
  echo -e "${GREEN}✓ Verification successful${NC}"
else
  echo -e "${RED}✗ Verification failed${NC}"
  exit 1
fi

echo -e "${YELLOW}Step 3: Testing all binaries in inst/github...${NC}"
dip test-codespaces-bins

# Check exit status
if [ $? -eq 0 ]; then
  echo -e "${GREEN}✓ All binaries tested successfully${NC}"
else
  echo -e "${RED}✗ Binary testing failed${NC}"
  exit 1
fi

echo -e "${GREEN}All tests passed! Your dotfiles are ready for GitHub Codespaces.${NC}"
echo -e "${YELLOW}To get a shell in the Codespaces container, run: dip codespaces-shell${NC}"