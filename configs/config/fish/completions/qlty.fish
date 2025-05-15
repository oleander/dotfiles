# QLTY completion for fish shell
# Place this file in ~/.config/fish/completions/

complete -c qlty -f

# Main commands
complete -c qlty -n "__fish_use_subcommand" -a "init" -d "Initialize QLTY in your project"
complete -c qlty -n "__fish_use_subcommand" -a "lint" -d "Lint your code"
complete -c qlty -n "__fish_use_subcommand" -a "run" -d "Run a specific command with QLTY"
complete -c qlty -n "__fish_use_subcommand" -a "help" -d "Show help for commands"
complete -c qlty -n "__fish_use_subcommand" -a "version" -d "Show QLTY version"

# Options for all commands
complete -c qlty -s h -l help -d "Show help for a command"
complete -c qlty -s v -l version -d "Show QLTY version"

# 'init' command options
complete -c qlty -n "__fish_seen_subcommand_from init" -l "force" -d "Force initialize even if configuration exists"

# 'lint' command options
complete -c qlty -n "__fish_seen_subcommand_from lint" -l "fix" -d "Apply autofixes to issues"
complete -c qlty -n "__fish_seen_subcommand_from lint" -l "watch" -d "Run in watch mode"