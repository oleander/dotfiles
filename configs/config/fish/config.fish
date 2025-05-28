# Environment Variables

# Sets core environment variables for the shell and other tools.
eval "$(/opt/homebrew/bin/brew shellenv)" # Initialize Homebrew environment

# Autojump integration
if test -f "/opt/homebrew/share/autojump/autojump.fish"
    source "/opt/homebrew/share/autojump/autojump.fish"
end

# Preferred editors
set -gx VISUAL nvim
set -gx EDITOR nvim
set -gx MANPATH "/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
set -gx PAGER "less -R"
set -gx LESSOPEN "|/usr/local/bin/lesspipe.sh %s"
fish_add_path $HOME/.cargo/bin
set -gx HOMEBREW_CASK_OPTS "--appdir=~/Applications"
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8
set -gx PYTHONCOERCECLOCALE 0
fish_add_path "$HOME/.dotfiles/bin"
set -gx GIT_MERGE_AUTOEDIT no
set -gx PYTHONUTF8 1

# --- PATH -------------------------------------------------------------------
# Consolidate all custom paths here to avoid duplication.
# fish_add_path silently ignores paths that are already present or nonexistent.
fish_add_path \
    "$HOME/.dotfiles/bin" \
    "$HOME/.cargo/bin" \
    "$HOME/.local/bin" \
    "$HOME/.rbenv/bin" \
    /opt/homebrew/bin \
    /opt/homebrew/opt/coreutils/libexec/gnubin \
    /opt/homebrew/opt/node@22/bin

# Overcommit settings
set -gx OVERCOMMIT_DISABLE 1

# SCCache setting
set -gx CACHE_DIR "$HOME/.cache"
if type -q sccache
    set -gx RUSTC_WRAPPER (which sccache)
end
set -gx RUST_ANALYZER_CACHE "$CACHE_DIR/rust-analyzer"
set -gx SCCACHE_CACHE_SIZE 200G
set -gx SCCACHE_DIRECT true

# Pipx executables live in ~/.local/bin, already included in the consolidated PATH above.

# --- Fabric Bootstrap -------------------------------------------------------
# Loads Fabric AI framework configuration if present.
if test -f "$HOME/.config/fabric/fabric-bootstrap.inc"
    source "$HOME/.config/fabric/fabric-bootstrap.inc" # Source if Fish-compatible; review if Zsh-specific and causing issues.
end

# --- Starship Prompt --------------------------------------------------------
# Initializes the Starship cross-shell prompt if installed.
if type -q starship
    set -gx STARSHIP_CONFIG "$HOME/.config/starship.toml"
    set -gx STARSHIP_CACHE "$HOME/.starship/cache"
    starship init fish | source
end

# --- OpenAI API Key ---------------------------------------------------------
# API key for OpenAI services, used by various CLI tools.
# Consider security implications if committing this file to a public repository.
set -gx OPENAI_API_KEY "dl://BA747198-1EEF-4C43-8A64-6E083A1A43C7/content"

# --- rbenv (Ruby Version Management) ----------------------------------------
# Initializes rbenv if installed.
if type -q rbenv
    rbenv init - | source
end

# --- gh (GitHub CLI) Token --------------------------------------------------
# Exports GitHub token for use by gh CLI and other tools.
if type -q gh
    set -l gh_token (gh auth token 2>/dev/null)
    if test -n "$gh_token"
        set -gx GITHUB_TOKEN "$gh_token"
        set -gx GITHUB_PERSONAL_ACCESS_TOKEN "$gh_token"
    else
        # Optional: print a warning if gh is installed but token is not found
        # echo "Warning: \`gh\` is installed but no auth token found." >&2
    end
end

# --- direnv (Directory Environment Management) ------------------------------
# Initializes direnv if installed, for per-directory environment variables.
if type -q direnv
    direnv hook fish | source
end

# bun ------------------------------------------------------------------------
# Adds Bun to PATH and generates Fish completions once if missing.
set -gx BUN_INSTALL "$HOME/.bun"
fish_add_path "$BUN_INSTALL/bin"

if type -q bun
    set -l __bun_comp_dir "$HOME/.config/fish/completions"
    set -l __bun_comp_file "$__bun_comp_dir/bun.fish"
    if not test -f $__bun_comp_file
        mkdir -p $__bun_comp_dir
        # Redirect stderr to keep the shell quiet if the sub-command is unavailable.
        bun completions fish >$__bun_comp_file 2>/dev/null
    end
end

# QLTY -----------------------------------------------------------------------
# Adds QLTY to PATH and generates Fish completions once if the CLI supports it.
set -gx QLTY_INSTALL "$HOME/.qlty"
fish_add_path "$QLTY_INSTALL/bin"

if type -q qlty
    set -l __qlty_comp_dir "$HOME/.config/fish/completions"
    set -l __qlty_comp_file "$__qlty_comp_dir/qlty.fish"
    if not test -f $__qlty_comp_file
        mkdir -p $__qlty_comp_dir
        # Try the two common sub-commands quietly; ignore errors.
        qlty completion fish >$__qlty_comp_file 2>/dev/null; or qlty completions fish >$__qlty_comp_file 2>/dev/null
    end
end

# Helper functions

# --- `most` command (Top Command Usage) -------------------------------------
# Displays the most frequently used commands, excluding common/trivial ones.
# Ported from a similar Zsh function; `fc` is Zsh-specific, so this uses `history`.
function most
    history | awk '{CMD[$1]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -vE "^(\./|cd|ls|cat|echo|grep|git|vim|nvim|sudo|exa|code|just|command|alias)" | column -c3 -s " " -t | sort -nr | nl | head -n25
end

# --- `chostname` (Hostname type) ---------------------------------------------
# Determines if the current hostname indicates a "home" or "work" environment
# based on whether the hostname ends with 'local'.
function chostname
    set -l H (hostname)
    if string match -r 'local$' -- "$H"
        echo home
    else
        echo work
    end
end

# --- Bash/Zsh Command Substitution Emulation (!! and !$) --------------------
# Provides `!!` (last command) and `!$` (last argument of last command)
# functionality, common in Bash and Zsh but not native to Fish.
# From https://travisbrady.github.io/posts/moving-to-fish-shell/
# which references fish wiki and StackOverflow.

function bind_bang
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f end-of-line
            commandline -i $history[1]
            commandline -f repaint
        case "*"
            commandline -i '$'
    end
end

# --- Custom Key Bindings -----------------------------------------------------
# Defines custom key bindings for the Fish shell.
# This function is called by Fish to set up user-defined bindings.
# It can be defined multiple times with `--append` to add bindings incrementally.
function fish_user_key_bindings
    bind ! bind_bang
    bind \$ bind_dollar

    # For fzf history (if installed via fzf.fish)
    # bind \cr 'fzf_history_search' # This might be set by fzf.fish automatically
end

# Load local configuration
if test -f "$HOME/.config/fish/config.local.fish"
    source "$HOME/.config/fish/config.local.fish"
end

# --- Fish Path Information -------------------------------------------------
# Fish automatically loads completions and functions from specific paths.
# For reference, these typically include:
#   ~/.config/fish/completions
#   ~/.config/fish/functions
#   Data directories (e.g., /usr/share/fish/completions)
#   And directories in $fish_complete_path / $fish_function_path.

# --- Informational Notes (formerly Zsh-specific comments) ------------------
# Notes on Shell Feature Equivalents
# * REPORTTIME: Starship can display command duration, or use `time command`.
# * Docker completions: If Docker Desktop is installed, it may provide completions.
#   Alternatively, Fisher can install a docker-completion plugin.
# * Zsh-specific plugins (zsh-completions, zsh-autosuggestions, zsh-syntax-highlighting)
#   are not needed; Fish provides these features natively or via Fisher plugins.

# --- Shell Behavior --------------------------------------------------------
# Clear the default greeting message
set -g fish_greeting

# Auto-accept suggestions with Tab (in insert mode)
bind -M insert \t accept-autosuggestion

# === Command Duration Reporting (Emulates Zsh \$REPORTTIME) ------------------
# Prints the runtime of any command that exceeds a configured threshold.
# Uses fish_preexec and fish_postexec events.
#
# Adjustable threshold:
set -g __reporttime_threshold_ms 5000 # Default: 5 seconds

# Event handler: Called before a command is executed.
function __reporttime_start --on-event fish_preexec
    # Save the millisecond timestamp when the command starts.
    set -g __reporttime_start_ms (date +%s%3N)
end

# Event handler: Called after a command has finished.
function __reporttime_stop --on-event fish_postexec
    # Compute elapsed time (in ms) and, if above the threshold, print it.
    if set -q __reporttime_start_ms
        set -l now_ms (date +%s%3N)
        set -l elapsed_ms (math $now_ms - $__reporttime_start_ms)
        if test $elapsed_ms -ge $__reporttime_threshold_ms
            set -l seconds (math --scale=2 "$elapsed_ms / 1000")
            echo -e (set_color yellow)"⏱  "$seconds"s"(set_color normal)
        end
        set -e __reporttime_start_ms
    end
end

# --- Docker CLI Completions Path --------------------------------------------
# Adds Docker Desktop's completions directory to $fish_complete_path if present.
# Docker Desktop for Mac/Windows often ships its own Fish completions here.
if test -d "$HOME/.docker/completions"
    if not contains -- "$HOME/.docker/completions" $fish_complete_path
        set -g fish_complete_path "$HOME/.docker/completions" $fish_complete_path
    end
end

# --- FZF-Powered History Search (Ctrl-R) ------------------------------------
# Provides an interactive Ctrl-R history search, powered by `fzf`.
# Activated only if fzf is installed.
if type -q fzf
    function fzf_history_search
        # Uses `awk` to deduplicate session history (which might not yet be merged/deduplicated by Fish itself).
        # `fzf` options: --tac (reverse order), --height, --reverse (layout), --border, --prompt, --query (initial query from commandline).
        set -l selected (history | awk '!seen[$0]++' | fzf --tac --height 40% --reverse --border --prompt='History> ' --query (commandline -t))
        if test -n "$selected"
            commandline --replace "$selected"
            commandline -f end-of-line
        end
    end

    function fish_user_key_bindings --append
        # Preserve any existing bindings (fish_user_key_bindings may have been
        # defined earlier). `bind -M insert` applies inside the insert mode.
        bind \cr fzf_history_search
    end
end

# --- Fisher Plugin Manager & Essential Plugins ------------------------------
# Bootstraps Fisher (Fish plugin manager) and installs essential plugins.
# This block only runs in interactive shells to prevent issues in scripts.
# Fisher itself is installed if not found.
if status --is-interactive
    if not functions -q fisher
        set -l fisher_path "$HOME/.config/fish/functions/fisher.fish"
        if not test -f $fisher_path
            echo "Installing fisher (Fish plugin manager)…" >&2
            curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
        else
            source $fisher_path
        end
    end

    if functions -q fisher
        set -l __plugins \
            PatrickF1/fzf.fish \
            jorgebucaran/autopair.fish
        for p in $__plugins
            if not begin
                    fisher list | string match -iq $p
                end
                fisher install $p
            end
        end
    end
end

# Git Aliases
alias gp git-push
alias gc git-verify-checkout # Assumes 'git-verify-checkout' is a custom script or alias
alias ggg 'git --no-pager add . && git commit --no-edit'
alias ggm 'git --no-pager commit --no-edit'
alias ok git-ok # Assumes 'git-ok' is an available script or command
alias okok 'ggg'

# Ruby Aliases

# --- Appended Aliases from Zsh config ---

# General Aliases
alias cr 'cd ~/Code'
alias dd 'cd ~/Desktop'
alias flush 'dscacheutil -flushcache'
alias update 'sudo /usr/libexec/locate.updatedb'
alias dot 'code ~/.dotfiles' # Will use 'cursor' due to the 'code' alias below
alias histall 'history --show-time' # Equivalent for zsh fc -il 1
alias vim nvim
alias vi nvim
alias sudo 'sudo ' # Trailing space is important for alias expansion
alias i issue # Assuming 'issue' is a command/script
alias c cheat # Assuming 'cheat' is a command/script
alias code cursor # Specific alias for 'code' to 'cursor'
alias make just

# Function to search history (from zsh alias h='history | grep -m 30 -i')
function h --description "Search history with grep, show top 30 results. Shows recent 30 if no arg."
    if test -n "$argv"
        history | command grep -i $argv | command head -n 30
    else
        history | command head -n 30 # Show recent history if no argument
    end
end

# Additional Git Aliases (original 'Git Aliases' section is above)
# Note: gp, gc, ggg, ggm, ok are already defined in the original file.
alias gpp 'git --no-pager pull'
alias gs 'git --no-pager status --ignore-submodules -s -b'
alias gd 'git --no-pager diff --stat'
alias gb 'git --no-pager branch'
alias gl git-log # Assuming 'git-log' is a custom script or alias
alias gdd 'git --no-pager diff'
alias gg commitment # Assuming 'commitment' is a custom script or alias
alias gm gm.fish # Assuming 'gm.fish' is a script in PATH

# Ruby Aliases (continued from above)
alias bb 'bundle exec'
alias b 'bundle install'

# Miscellaneous & Tool Specific Aliases
alias files 'git --no-pager diff --diff-filter=AM --name-only origin/HEAD^ HEAD -- (pwd) | sort'
alias crate context-extractor
alias help2 context-extractor
alias ?? 'gh copilot suggest -t shell'
alias git? 'gh copilot suggest -t git'
alias gh? 'gh copilot suggest -t gh'
alias explain 'gh copilot explain'
alias v view-github-project # Assuming 'view-github-project' is a command/script
alias f format-new-files-since-branch # Assuming 'format-new-files-since-branch' is a command/script
alias format-cursor 'npx prettier --parser markdown --write ".cursor/rules/*.mdc"'
