# Environment Variables
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

# Overcommit settings
set -gx OVERCOMMIT_DISABLE "1"

# SCCache setting
set -gx CACHE_DIR "$HOME/.cache"
set -gx RUSTC_WRAPPER (which sccache)
set -gx RUST_ANALYZER_CACHE "$CACHE_DIR/rust-analyzer"
set -gx SCCACHE_CACHE_SIZE "200G"
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
alias history 'history' # Fish's built-in history command
alias vim nvim
alias sudo 'sudo '
alias h 'history | grep -m 30 -i' # Fish history search is different, consider fzf
alias i 'issue' # Assuming 'issue' is a script/alias defined elsewhere or a command
alias c 'cheat' # Assuming 'cheat' is a script/alias defined elsewhere or a command

# git aliases
alias gp 'git-push'
alias gpp 'git --no-pager pull'
alias gs 'git --no-pager status --ignore-submodules -s -b'
alias gd 'git --no-pager diff --stat'
alias gb 'git --no-pager branch'
alias gl 'git-log' # Assuming git-log is a custom script or alias
alias gdd 'git --no-pager diff'
alias gg 'commitment' # Assuming 'commitment' is a script/alias
alias gm 'gm.fish' # Ensure gm.fish is in PATH and executable, or define as function
alias gc 'git-verify-checkout' # Assuming git-verify-checkout is a script/alias
alias ggg 'git --no-pager add . && git commit --no-edit'
alias ggm 'git --no-pager commit --no-edit'
alias ok 'git-ok' # Assuming git-ok is a script or alias

# ruby aliases
alias bb 'bundle exec'
alias b 'bundle install'

alias files 'git --no-pager diff --diff-filter=AM --name-only origin/HEAD^ HEAD -- (pwd) | sort' # (pwd) is fish syntax

alias vi 'nvim'

alias make 'just'
alias crate 'context-extractor' # Assuming context-extractor is a script/alias
alias help2 'context-extractor'

alias '??' 'gh copilot suggest -t shell'
alias 'git?' 'gh copilot suggest -t git'
alias 'gh?' 'gh copilot suggest -t gh'
alias 'explain' 'gh copilot explain'

alias v 'view-github-project' # Assuming view-github-project is a script/alias
alias f 'format-new-files-since-branch' # Assuming this is a script/alias
alias code 'cursor'

set -gx OPENAI_API_KEY "dl://BA747198-1EEF-4C43-8A64-6E083A1A43C7/content" # Ensure this is how you want to handle API keys

# PATH additions (some might be redundant due to earlier fish_add_path)
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.rbenv/bin"
fish_add_path "/opt/homebrew/opt/coreutils/libexec/gnubin"
fish_add_path "/opt/homebrew/opt/node@22/bin" # Used by @modelcontextprotocol/server-github in VSCode

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

# bun
set -gx BUN_INSTALL "$HOME/.bun"
fish_add_path "$BUN_INSTALL/bin"
# Bun completions are typically handled by oh-my-fish plugins or fisher.
# `source "$HOME/.bun/_bun"` is zsh/bash specific.
# We will rely on fzf for history search and a plugin for bun completions if needed later.

# QLTY
set -gx QLTY_INSTALL "$HOME/.qlty"
fish_add_path "$QLTY_INSTALL/bin"
# QLTY completions: `[ -s "/opt/homebrew/share/zsh/site-functions/_qlty" ] && source "/opt/homebrew/share/zsh/site-functions/_qlty"`
# Fish completions for qlty would typically be in ~/.config/fish/completions/qlty.fish or installed via a plugin.

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
        echo "home"
    else
        echo "work"
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
if command -v gh > /dev/null
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

starship init fish | source

set -g fish_greeting

eval "$(/opt/homebrew/bin/brew shellenv)"
