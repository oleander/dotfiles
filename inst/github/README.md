# GitHub Codespaces Scripts

These scripts are designed for use in GitHub Codespaces environments and are automatically linked to `~/.local/bin/inst-*` by the dotfiles installation process.

## Core Setup Scripts

- `setup`: Main setup script for GitHub Codespaces environment
  - Installs dotfiles with GitHub-specific configuration
  - Fixes permissions and configuration issues
  - Sets up autojump and configures zsh properly

- `test`: Verifies that the GitHub Codespaces setup is working correctly
  - Tests compinit to ensure it doesn't prompt for input
  - Checks that autojump is installed and properly configured
  - Verifies all binaries in `inst/github` are linked correctly

## Usage

In a GitHub Codespaces environment:

1. During initial setup:
   ```bash
   inst-setup   # Run once to set up the environment
   inst-test    # Verify everything is working
   ```

2. If you see issues with your environment:
   ```bash
   inst-test    # Identify problems
   inst-setup   # Fix common issues
   ```

## Other Scripts

- `autojump`: Installs autojump for directory navigation
- `brew`: Installs Homebrew package manager
- `cargo`: Sets up Rust's Cargo package manager
- `git-ai`: Installs Git AI utilities
- `oh-my-zsh`: Installs Oh My Zsh framework
- `rust`: Installs Rust programming language
- `zsh`: Sets up Zsh shell

## Testing Locally

To test these scripts in a local environment that mimics GitHub Codespaces:

```bash
# Using dip (recommended)
dip install-codespaces  # Run setup
dip verify-codespaces   # Verify installation
dip codespaces-shell    # Get an interactive shell

# Or directly with Docker Compose
docker-compose run --rm codespaces ./inst/github/setup
docker-compose run --rm codespaces ./inst/github/test
```