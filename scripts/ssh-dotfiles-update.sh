#!/bin/bash

# Script to update dotfiles on remote hosts when connecting via SSH
# Called from SSH config LocalCommand

# Constants
DOTFILES_DIR="$HOME/dotfiles"
DOTFILES_REPO="https://github.com/oleander/dotfiles"
LOG_FILE="/tmp/dotfiles-update-$(date +%Y%m%d-%H%M%S).log"
TIMEOUT=15
MAX_RETRIES=2

# Function to show spinner with emojis
show_spinner() {
  local pid=$1
  local delay=0.1
  local spinstr='⏳ ⌛ 🔄 📦 🚀'
  while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
    local temp=${spinstr#?}
    printf " %c " "$spinstr"
    local spinstr=$temp${spinstr%"$temp"}
    printf "\b\b\b"
    sleep $delay
  done
  printf "    \b\b\b\b"
}

# Function to log errors
log_error() {
  local message="$1"
  echo "❌ ERROR: $message" | tee -a "$LOG_FILE" >&2
}

# Function to log success
log_success() {
  local message="$1"
  echo "✅ $message"
}

# Function to check internet connectivity
check_internet() {
  # Try multiple reliable domains with a timeout
  for domain in github.com google.com cloudflare.com; do
    if timeout $TIMEOUT ping -c 1 $domain >/dev/null 2>&1; then
      return 0
    fi
  done
  return 1
}

# Function to run a command with timeout and retry
run_with_retry() {
  local cmd="$1"
  local desc="$2"
  local retry=0

  while [ $retry -lt $MAX_RETRIES ]; do
    # Don't output anything for successful operations
    echo -n "🔄 $desc " >&2

    # Run command in background and show spinner
    eval "timeout $TIMEOUT $cmd" >>"$LOG_FILE" 2>&1 &
    local cmd_pid=$!
    show_spinner $cmd_pid
    wait $cmd_pid
    local exit_code=$?

    if [ $exit_code -eq 0 ]; then
      echo -e "\r✅ $desc    " >&2
      return 0
    elif [ $exit_code -eq 124 ]; then
      echo -e "\r⏱️  $desc timed out, retrying..." >&2
      retry=$((retry+1))
    else
      echo -e "\r❌ $desc failed (exit code: $exit_code)" >&2
      retry=$((retry+1))
    fi
  done

  log_error "$desc failed after $MAX_RETRIES retries. See log at $LOG_FILE"
  return 1
}

# Ensure we have a clean environment
set -o pipefail

# Make sure git is installed
if ! command -v git >/dev/null 2>&1; then
  log_error "Git is not installed. Cannot proceed."
  exit 0  # Exit gracefully - don't interfere with SSH login
fi

# Main script
(
  # Check internet connectivity first
  if ! check_internet; then
    log_error "No internet connectivity detected. Skipping dotfiles update."
    exit 0
  fi

  # Set git options for robustness
  GIT_OPTS="-c gc.auto=0 -c protocol.version=2 -c http.timeout=$TIMEOUT -c pull.timeout=$TIMEOUT -c clone.timeout=$TIMEOUT -c core.askPass=true"

  if [[ -d "$DOTFILES_DIR" ]]; then
    # Attempt to update existing dotfiles
    if ! cd "$DOTFILES_DIR" 2>>"$LOG_FILE"; then
      log_error "Failed to change to $DOTFILES_DIR directory"
      exit 1
    fi

    # Fetch before doing anything else to see if remote is reachable
    if ! run_with_retry "git $GIT_OPTS fetch --quiet" "Checking remote connectivity"; then
      log_error "Could not connect to remote repository. Skipping update."
      exit 0
    fi

    # Stash any local changes
    run_with_retry "git $GIT_OPTS stash -q" "Stashing local changes" || true

    git "$GIT_OPTS" stash --include-untracked

    # Pull updates
    if ! run_with_retry "git $GIT_OPTS pull --quiet" "Pulling latest changes"; then
      # If pull fails, try harder with a reset
      log_error "Pull failed, attempting reset to origin/master"
      if ! run_with_retry "git $GIT_OPTS fetch --quiet && git $GIT_OPTS reset --hard origin/master" "Resetting to origin/master"; then
        log_error "Failed to reset repository. Manual intervention may be required."
        exit 1
      fi
    fi

    log_success "Dotfiles repository updated successfully"

    # Run install script if it exists
    if [[ -f "./install" ]]; then
      if [[ -x "./install" ]]; then
        if ! run_with_retry "./install" "Running install script"; then
          log_error "Install script failed. Check $LOG_FILE for details."
          exit 1
        fi
      else
        # Try to run with bash if not executable
        if ! run_with_retry "bash ./install" "Running install script with bash"; then
          log_error "Install script failed. Check $LOG_FILE for details."
          exit 1
        fi
      fi
      log_success "Dotfiles install script completed successfully"
    else
      echo "ℹ️ No install script found at $DOTFILES_DIR/install"
    fi

  else
    # First-time installation
    echo "🆕 Installing dotfiles for the first time..."

    # Create parent directory if needed
    parent_dir=$(dirname "$DOTFILES_DIR")
    if [[ ! -d "$parent_dir" ]]; then
      if ! mkdir -p "$parent_dir" 2>>"$LOG_FILE"; then
        log_error "Failed to create parent directory $parent_dir"
        exit 1
      fi
    fi

    # Clone repository
    if ! run_with_retry "git $GIT_OPTS clone --quiet $DOTFILES_REPO $DOTFILES_DIR" "Cloning dotfiles repository"; then
      log_error "Failed to clone dotfiles repository from $DOTFILES_REPO"
      exit 1
    fi

    # Change to the dotfiles directory
    if ! cd "$DOTFILES_DIR" 2>>"$LOG_FILE"; then
      log_error "Failed to change to $DOTFILES_DIR directory after cloning"
      exit 1
    fi

    # Run install script if it exists
    if [[ -f "./install" ]]; then
      if [[ -x "./install" ]]; then
        if ! run_with_retry "./install" "Running install script"; then
          log_error "Install script failed. Check $LOG_FILE for details."
          exit 1
        fi
      else
        # Try to run with bash if not executable
        if ! run_with_retry "bash ./install" "Running install script with bash"; then
          log_error "Install script failed. Check $LOG_FILE for details."
          exit 1
        fi
      fi
      log_success "Dotfiles installed successfully"
    else
      log_error "No install script found at $DOTFILES_DIR/install after cloning"
      exit 1
    fi
  fi

  # Final success message only if everything went well
  echo "🎉 Dotfiles operation completed successfully!"

) # End of subshell to contain any errors

# Exit gracefully so SSH connection isn't affected
exit 0
