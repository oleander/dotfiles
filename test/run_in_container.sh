#!/bin/bash
set -euo pipefail

# Get the directory containing this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Ensure we're in the repository root
cd "${REPO_ROOT}"

echo "🧹 Cleaning up any previous test containers..."
docker rm -f dotfiles-test 2>/dev/null || true

echo "🏗️  Building test container..."
docker build -t dotfiles-test -f "${SCRIPT_DIR}/Dockerfile" .

echo "🚀 Running test in container..."
docker run --rm \
  --name dotfiles-test \
  -v "${REPO_ROOT}:/dotfiles" \
  -w /dotfiles \
  dotfiles-test \
  ./test/test_ssh_keys.sh "${REPO_ROOT}"

status=$?

echo "🧹 Cleaning up..."
docker rm -f dotfiles-test 2>/dev/null || true

exit $status
