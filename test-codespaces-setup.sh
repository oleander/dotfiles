#!/usr/bin/env bash

# Colors for better readability
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Building and running Codespaces container to test installation...${NC}"

# Build and run the test container
docker-compose -f docker-compose.test.yml up --build

# Check if container ran successfully
if [ $? -eq 0 ]; then
  echo -e "${GREEN}Test completed successfully!${NC}"
else
  echo -e "${RED}Test failed. Check container output for details.${NC}"
  exit 1
fi

# Show logs from the container
echo -e "${YELLOW}Container logs:${NC}"
docker-compose -f docker-compose.test.yml logs codespaces