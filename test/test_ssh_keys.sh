#!/bin/bash
set -euo pipefail

# Create a temporary directory for testing
TEST_DIR=$(mktemp -d)
TEST_SSH_DIR="$TEST_DIR/.ssh"
TEST_KEY_NAME="test_dotfiles_key"
TEST_KEY_PATH="$TEST_SSH_DIR/$TEST_KEY_NAME"

echo "🔑 Setting up test environment in temporary directory..."

# Store original .ssh directory permissions if it exists
ORIGINAL_SSH_PERMS=""
if [ -d "$HOME/.ssh" ]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        ORIGINAL_SSH_PERMS=$(stat -f "%Lp" "$HOME/.ssh")
    else
        ORIGINAL_SSH_PERMS=$(stat -c "%a" "$HOME/.ssh")
    fi
fi

# Create test .ssh directory with correct permissions
mkdir -p "$TEST_SSH_DIR"
chmod 700 "$TEST_SSH_DIR"

# Function to cleanup on exit
cleanup() {
    echo "🧹 Cleaning up..."
    rm -rf "$TEST_DIR"
}
trap cleanup EXIT

# Generate test SSH key
echo "🔨 Generating test SSH key..."
ssh-keygen -t rsa -b 4096 -f "$TEST_KEY_PATH" -N "" -q

# Verify test key was created with correct permissions
if [ ! -f "${TEST_KEY_PATH}" ] || [ ! -f "${TEST_KEY_PATH}.pub" ]; then
    echo "❌ Failed to generate test SSH keys"
    exit 1
fi

# Function to get permissions in octal format, compatible with both Linux and macOS
get_perms() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        stat -f "%Lp" "$1"
    else
        stat -c "%a" "$1"
    fi
}

# Verify key permissions
PRIVATE_KEY_PERMS=$(get_perms "${TEST_KEY_PATH}")
PUBLIC_KEY_PERMS=$(get_perms "${TEST_KEY_PATH}.pub")

if [ "$PRIVATE_KEY_PERMS" != "600" ]; then
    echo "❌ Private key has incorrect permissions: $PRIVATE_KEY_PERMS"
    exit 1
fi

if [ "$PUBLIC_KEY_PERMS" != "644" ]; then
    echo "❌ Public key has incorrect permissions: $PUBLIC_KEY_PERMS"
    exit 1
fi

echo "✅ Test SSH keys generated successfully with correct permissions"

# Store key checksums and permissions before installation
if [[ "$OSTYPE" == "darwin"* ]]; then
    PRIVATE_KEY_SUM=$(shasum -a 256 "$TEST_KEY_PATH" | cut -d' ' -f1)
    PUBLIC_KEY_SUM=$(shasum -a 256 "${TEST_KEY_PATH}.pub" | cut -d' ' -f1)
else
    PRIVATE_KEY_SUM=$(sha256sum "$TEST_KEY_PATH" | cut -d' ' -f1)
    PUBLIC_KEY_SUM=$(sha256sum "${TEST_KEY_PATH}.pub" | cut -d' ' -f1)
fi

PRIVATE_KEY_PERMS=$(get_perms "$TEST_KEY_PATH")
PUBLIC_KEY_PERMS=$(get_perms "${TEST_KEY_PATH}.pub")
SSH_DIR_PERMS=$(get_perms "$TEST_SSH_DIR")

# Temporarily set HOME to our test directory for the install script
OLD_HOME="$HOME"
export HOME="$TEST_DIR"

# Run the install script
echo "🚀 Running install script..."
(cd "$OLD_HOME" && ./install)

# Restore original HOME
export HOME="$OLD_HOME"

# Verify keys still exist and haven't been modified
echo "🔍 Verifying SSH keys survived installation..."

# Check existence
if [ ! -f "$TEST_KEY_PATH" ] || [ ! -f "${TEST_KEY_PATH}.pub" ]; then
    echo "❌ Test failed: SSH keys were removed during installation"
    exit 1
fi

# Check content integrity
if [[ "$OSTYPE" == "darwin"* ]]; then
    NEW_PRIVATE_KEY_SUM=$(shasum -a 256 "$TEST_KEY_PATH" | cut -d' ' -f1)
    NEW_PUBLIC_KEY_SUM=$(shasum -a 256 "${TEST_KEY_PATH}.pub" | cut -d' ' -f1)
else
    NEW_PRIVATE_KEY_SUM=$(sha256sum "$TEST_KEY_PATH" | cut -d' ' -f1)
    NEW_PUBLIC_KEY_SUM=$(sha256sum "${TEST_KEY_PATH}.pub" | cut -d' ' -f1)
fi

if [ "$PRIVATE_KEY_SUM" != "$NEW_PRIVATE_KEY_SUM" ]; then
    echo "❌ Test failed: Private key was modified during installation"
    echo "Original: $PRIVATE_KEY_SUM"
    echo "Current:  $NEW_PRIVATE_KEY_SUM"
    exit 1
fi

if [ "$PUBLIC_KEY_SUM" != "$NEW_PUBLIC_KEY_SUM" ]; then
    echo "❌ Test failed: Public key was modified during installation"
    echo "Original: $PUBLIC_KEY_SUM"
    echo "Current:  $NEW_PUBLIC_KEY_SUM"
    exit 1
fi

# Check permissions
NEW_PRIVATE_KEY_PERMS=$(get_perms "$TEST_KEY_PATH")
NEW_PUBLIC_KEY_PERMS=$(get_perms "${TEST_KEY_PATH}.pub")
NEW_SSH_DIR_PERMS=$(get_perms "$TEST_SSH_DIR")

if [ "$PRIVATE_KEY_PERMS" != "$NEW_PRIVATE_KEY_PERMS" ]; then
    echo "❌ Test failed: Private key permissions changed during installation"
    echo "Original: $PRIVATE_KEY_PERMS"
    echo "Current:  $NEW_PRIVATE_KEY_PERMS"
    exit 1
fi

if [ "$PUBLIC_KEY_PERMS" != "$NEW_PUBLIC_KEY_PERMS" ]; then
    echo "❌ Test failed: Public key permissions changed during installation"
    echo "Original: $PUBLIC_KEY_PERMS"
    echo "Current:  $NEW_PUBLIC_KEY_PERMS"
    exit 1
fi

if [ "$SSH_DIR_PERMS" != "$NEW_SSH_DIR_PERMS" ]; then
    echo "❌ Test failed: SSH directory permissions changed during installation"
    echo "Original: $SSH_DIR_PERMS"
    echo "Current:  $NEW_SSH_DIR_PERMS"
    exit 1
fi

echo "✅ Test passed: SSH keys and directory were preserved with correct content and permissions"

echo "✨ Test completed successfully"
