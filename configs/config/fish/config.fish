# Environment Variables

eval "$(/opt/homebrew/bin/brew shellenv)"
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

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
# ZSH_DOTENV_PROMPT is not directly applicable; prompt is handled by Starship or themes
fish_add_path "$HOME/.dotfiles/bin"
set -gx GIT_MERGE_AUTOEDIT no
# BUILDX_BUILDER can be set if needed:
# set -gx BUILDX_BUILDER "desktop-linux"

# Locale settings (already set above, PYTHONUTF8 is Python-specific, set if running Python scripts directly)
set -gx PYTHONUTF8 1

# --- PATH -------------------------------------------------------------------
# Consolidate all custom paths here to avoid duplication.
# fish_add_path silently ignores paths that are already present or nonexistent.
fish_add_path \
    "$HOME/.dotfiles/bin" \
    "$HOME/.cargo/bin" \
    "$HOME/.local/bin" \
    "$HOME/.rbenv/bin" \
    "/opt/homebrew/opt/coreutils/libexec/gnubin" \
    "/opt/homebrew/opt/node@22/bin"

# Overcommit settings
set -gx OVERCOMMIT_DISABLE 1

# SCCache setting
set -gx CACHE_DIR "$HOME/.cache"
set -gx RUSTC_WRAPPER (which sccache)
set -gx RUST_ANALYZER_CACHE "$CACHE_DIR/rust-analyzer"
set -gx SCCACHE_CACHE_SIZE 200G
set -gx SCCACHE_DIRECT true

# Pipx path
fish_add_path "$HOME/.local/bin"

# Fabric bootstrap
if test -f "$HOME/.config/fabric/fabric-bootstrap.inc"
    source "$HOME/.config/fabric/fabric-bootstrap.inc" # This might need to be fish compatible or removed if zsh specific
end

# Starship
if command -v starship >/dev/null 2>&1
    set -gx STARSHIP_CONFIG "$HOME/.config/starship.toml"
    set -gx STARSHIP_CACHE "$HOME/.starship/cache"
    starship init fish | source
end

# Ensure .local/bin is in PATH (already added by fish_add_path if it was the first instance)
# fish_add_path "$HOME/.local/bin" # Redundant if already covered

# Aliases
alias cr 'cd ~/Code'
alias dd 'cd ~/Desktop'
alias flush 'dscacheutil -flushcache'
alias update 'sudo /usr/libexec/locate.updatedb'
alias dot 'code ~/.dotfiles'
alias history history # Fish's built-in history command
alias vim nvim
alias sudo 'sudo '
alias h 'history | grep -m 30 -i' # Fish history search is different, consider fzf
alias i issue # Assuming 'issue' is a script/alias defined elsewhere or a command
alias c cheat # Assuming 'cheat' is a script/alias defined elsewhere or a command

# git aliases
alias gp git-push
alias gpp 'git --no-pager pull'
alias gs 'git --no-pager status --ignore-submodules -s -b'
alias gd 'git --no-pager diff --stat'
alias gb 'git --no-pager branch'
alias gl git-log # Assuming git-log is a custom script or alias
alias gdd 'git --no-pager diff'
alias gg commitment # Assuming 'commitment' is a script/alias
alias gm 'gm.fish' # Ensure gm.fish is in PATH and executable, or define as function
alias gc git-verify-checkout # Assuming git-verify-checkout is a script/alias
alias ggg 'git --no-pager add . && git commit --no-edit'
alias ggm 'git --no-pager commit --no-edit'
alias ok git-ok # Assuming git-ok is a script or alias

# ruby aliases
alias bb 'bundle exec'
alias b 'bundle install'

alias files 'git --no-pager diff --diff-filter=AM --name-only origin/HEAD^ HEAD -- (pwd) | sort' # (pwd) is fish syntax

alias vi nvim

alias make just
alias crate context-extractor # Assuming context-extractor is a script/alias
alias help2 context-extractor

alias '??' 'gh copilot suggest -t shell'
alias 'git?' 'gh copilot suggest -t git'
alias 'gh?' 'gh copilot suggest -t gh'
alias explain 'gh copilot explain'

alias v view-github-project # Assuming view-github-project is a script/alias
alias f format-new-files-since-branch # Assuming this is a script/alias
alias code cursor

set -gx OPENAI_API_KEY "dl://BA747198-1EEF-4C43-8A64-6E083A1A43C7/content" # Ensure this is how you want to handle API keys

# rbenv
if command -v rbenv >/dev/null 2>&1
    rbenv init - | source
end

# gh token
if command -v gh >/dev/null 2>&1
    set -gx GITHUB_TOKEN (gh auth token)
    set -gx GITHUB_PERSONAL_ACCESS_TOKEN (gh auth token)
end

# direnv
if command -v direnv >/dev/null 2>&1
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
        bun completions fish > $__bun_comp_file 2>/dev/null
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
        qlty completion fish > $__qlty_comp_file 2>/dev/null ; or \
        qlty completions fish > $__qlty_comp_file 2>/dev/null
    end
end

# Functions from zshrc

# `most` command - fc is zsh specific. Fish history is just `history`.
# For a similar functionality, you might need a more complex script or a dedicated tool.
# A simplified version focusing on Fish's history:
function most
    history | awk '{CMD[$1]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -vE "^(\./|cd|ls|cat|echo|grep|git|vim|nvim|sudo|exa|code|just|command|alias)" | column -c3 -s " " -t | sort -nr | nl | head -n25
end

# Determine hostname
function chostname
    set -l H (hostname)
    if string match -r 'local$' -- "$H"
        echo home
    else
        echo work
    end
end

# Emulate Bash/Zsh Command Substitution (!! and !$)
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

# gh copilot alias
if command -v gh >/dev/null
    # gh copilot alias -- fish | source # This was the old way
    # The new way might be to use the gh copilot CLI to generate suggestions
    # and rely on the aliases already set up:
    # alias '??' 'gh copilot suggest -t shell'
    # alias 'git?' 'gh copilot suggest -t git'
    # alias 'gh?' 'gh copilot suggest -t gh'
    # The blog post about fzf.fish suggests it comes with Ctrl-r, so we'll focus on that
end

# Fish automatically loads completions from:
# ~/.config/fish/completions
# $__fish_data_dir/completions
# $__fish_config_dir/completions
# And directories in $fish_complete_path

# REPORTTIME equivalent: Fish doesn't have a direct equivalent for REPORTTIME.
# For command timing, you can use `time command` or enable it in some prompts (like Starship).
# Starship can show command duration.

# Docker completions:
# If Docker Desktop is installed, it might provide Fish completions.
# Otherwise, a plugin like `docker-completion` for oh-my-fish or fisher can be used.

# Zinit plugins are Zsh specific. We will use OMF and Fisher for Fish plugins.
# zsh-users/zsh-completions -> handled by fish native completions + plugins
# zsh-users/zsh-autosuggestions -> fish has this built-in
# zsh-users/zsh-syntax-highlighting -> fish has this built-in

# starship init fish | source

set -g fish_greeting

bind -M insert \t accept-autosuggestion

# === Command duration reporting (replacement for zsh $REPORTTIME) ===
# In zsh, setting REPORTTIME prints the runtime of any command that
# exceeds the configured threshold. Fish doesn't have an exact built-in
# equivalent, but we can emulate it using the fish_preexec / fish_postexec
# events. The logic below prints a yellow, right-aligned duration marker
# whenever the last command ran for more than 5 seconds.
#
# Feel free to adjust the threshold by changing __reporttime_threshold_ms.
set -g __reporttime_threshold_ms 5000  # 5 seconds

function __reporttime_start --on-event fish_preexec
    # Save the millisecond timestamp when the command starts.
    set -g __reporttime_start_ms (date +%s%3N)
end

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

# --- Docker CLI completions --------------------------------------------------
# Docker Desktop ships its own completions in ~/.docker/completions.
# Tell fish to look there as well (if the directory exists).
if test -d "$HOME/.docker/completions"
    if contains -- $HOME/.docker/completions $fish_complete_path
        # already present, nothing to do
    else
        set -g fish_complete_path $HOME/.docker/completions $fish_complete_path
    end
end

# FZF-powered history search ---------------------------------------------------
# Provides an interactive Ctrl-R history search similar to bash/zsh, but powered
# by `fzf`. Only activated if fzf is installed.
if type -q fzf
    function fzf_history_search
        # The --tac flag shows most-recent entries at the top. We also deduplicate
        # via `awk` because fish history can contain repeated commands within the
        # session when deduping hasn't happened yet.
        set -l selected (history | awk '!seen[$0]++' | fzf --tac --height 40% --reverse --border --prompt='History> ' --query (commandline -t))
        if test -n "$selected"
            commandline --replace "$selected"
            commandline -f end-of-line
        end
    end

    function fish_user_key_bindings --append
        # Preserve any existing bindings (fish_user_key_bindings may have been
        # defined earlier). `bind -M insert` applies inside the insert mode.
        bind \cr 'fzf_history_search'
    end
end

# -----------------------------------------------------------------------------
# Fisher plugin manager bootstrap & essential plugins
# Only in interactive shells to avoid loops in non-interactive batch runs.
# -----------------------------------------------------------------------------
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
            if not begin; fisher list | string match -iq $p; end
                fisher install $p
            end
        end
    end
end
