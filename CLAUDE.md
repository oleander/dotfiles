# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## System Overview

This is a dotfiles repository managed using Dotbot, containing configuration files for various tools and environments. It supports multiple platforms including macOS, Home Assistant, and GitHub Codespaces.

## Build/Test Commands

- Install dotfiles: `./install` or `dotbot -c install.conf.yaml`
- Install for specific environment: `dip install-homeassistant`, `dip install-macos`, or `dip install-github`
- Brew commands: `brew bundle install`, `brew bundle dump --cleanup --all`
- Run tests: `dip test-homeassistant` or `dip test-macos`
- Test single script: `dip test-script <script-name>`
- Run Ruby specs: `dip rspec <file-path>`
- Run specific specs from branch: `git diff --name-only --diff-filter=d master...HEAD | grep '_spec.rb$' | dip rspec`

## Linting and Formatting

- Ruby: `dip rubocop -A <files>` (always run specs after changes)
- Lint all changed files: `git diff --name-only --diff-filter=d master...HEAD` then `dip rubocop -A` on results

## Code Style Guidelines

- Ruby: Double quotes, 100-char line length, proper class structure (see configs/rubocop.yml)
- Rust: 140-char line width, 2-space indentation, modules organized by StdExternalCrate
- Fish: Fish-specific syntax in configurations, functions in ~/.config/fish/functions, completions in ~/.config/fish/completions
- Cursor rules follow naming convention: PREFIX-name.mdc (see cursor/000-cursor-rules.mdc)
- Keep code concise and follow existing patterns in files being modified
- Test coverage is expected for all changes

## Repository Structure

- `configs/`: Contains all configuration files that get symlinked to home directory
  - `configs/config/`: Files that get symlinked to ~/.config/
  - `configs/ssh/`: SSH configuration files
- `inst/`: Installation scripts for different environments (macos, homeassistant, github)
- `bin/`: Binary scripts
- `cursor/`: Cursor AI assistant rules
- `dotbot/`: Dotbot submodule for handling dotfile installation
- `test/`: Test scripts

## Installation Process

The dotfiles installation uses Dotbot to:
1. Clean specified directories
2. Create necessary directories
3. Link configuration files to their appropriate locations
4. Run installation scripts for tools like starship, zsh, git-ai, and autojump

Different environments (macos, homeassistant, github) are managed through Docker containers defined in docker-compose.yml and orchestrated with dip commands.