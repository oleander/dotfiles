#!/usr/bin/env bash

# Function to check if we should skip binary installations
should_skip_binaries() {
    if [[ "${QUICK:-false}" == "true" ]]; then
        echo "QUICK mode enabled, skipping binary installation"
        return 0
    fi
    return 1
}

# Function to check if a command exists and skip if in QUICK mode
check_command() {
    local cmd=$1
    local name=${2:-$1}

    if command -v "$cmd" &>/dev/null; then
        echo "$name is already installed"
        return 0
    fi

    if should_skip_binaries; then
        echo "Skipping $name installation (QUICK mode)"
        return 0
    fi

    return 1
}
