# CLAUDE.md - Agent Instructions

## Build/Test Commands

- Install dotfiles: `dotbot -c install.conf.yaml`
- Brew commands: `brew bundle install`, `brew bundle dump --cleanup --all`
- Run tests: `dip test-homeassistant`
- Test single script: `dip test-script <script-name>`
- Run Ruby specs: `dip rspec <file-path>`
- Run specific specs from branch: `git diff --name-only --diff-filter=d master...HEAD | grep '_spec.rb$' | dip rspec`

## Linting and Formatting

- Ruby: `dip rubocop -A <files>` (always run specs after changes)
- Lint all changed files: `git diff --name-only --diff-filter=d master...HEAD` then `dip rubocop -A` on results

## Code Style Guidelines

- Ruby: Double quotes, 100-char line length, proper class structure (see configs/rubocop.yml)
- Rust: 140-char line width, 2-space indentation, modules organized by StdExternalCrate
- Cursor rules follow naming convention: PREFIX-name.mdc (see cursor/000-cursor-rules.mdc)
- Keep code concise and follow existing patterns in files being modified
- Test coverage is expected for all changes
