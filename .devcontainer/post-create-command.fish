#!/usr/bin/env fish

function log
    echo (set_color yellow)"[setup.fish]"(set_color normal) $argv
end

log "Updating package lists..."
sudo apt-get update

log "Installing curl..."
sudo apt-get install -y curl

log "Updating git submodules..."
git submodule update --init --remote || begin
    log (set_color red)"Error updating submodules. Some submodules might be misconfigured."(set_color normal)
    log "Checking .gitmodules file..."
    cat .gitmodules
    log "If you see any issues in the .gitmodules file, please correct them manually."
end

log "Installing starship..."
curl -sS https://starship.rs/install.sh | sh -s -- --yes

log "Configuring Fish history..."
echo 'set -gx HISTFILE /home/vscode/.local/share/fish/fish_history' >> /home/vscode/.config/fish/config.fish

# Run Dotbot
set CONFIG "install.conf.yaml"
set DOTBOT_DIR "dotbot"

set DOTBOT_BIN "bin/dotbot"
set BASEDIR (dirname (status -f))

cd "$BASEDIR"
git -C "$DOTBOT_DIR" submodule sync --quiet --recursive
git submodule update --init --recursive "$DOTBOT_DIR"

log "Running Dotbot..."
"$BASEDIR/$DOTBOT_DIR/$DOTBOT_BIN" -d "$BASEDIR" -c "$CONFIG" "$argv" || begin
    log (set_color red)"Error running Dotbot. Please check your Dotbot configuration."(set_color normal)
end

log (set_color green)"Setup complete!"(set_color normal)
