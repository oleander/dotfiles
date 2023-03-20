#!env fish

if not set -q argv[1]
  echo "Usage: gg <commit message>"
  exit 1
end

# Get the current branch name
set branch (git rev-parse --abbrev-ref HEAD)

# Store the arguments in a var called $message
set message $argv

# Uppercase first letter of commit message
set message (echo $message | sed 's/\(.\)/\U\1/')

# If the branch name matches ANYTHING-1234, then prefix the commit message with ANYTHING-1234
if echo $branch | grep -q -E '^[A-Z]+-[0-9]+'
  # Unless the commit message $message already starts with ANYTHING-1234
  if not echo $message | grep -q -E '^[A-Z]+-[0-9]+'
    set message "$branch $message"
  end
end

# Check if the --dry-run flag was passed anywhere in $args
# if so, print the commit message and exit
if echo $argv | grep -q -- --dry-run
  echo "[Dry run] Commit message: $message"
  exit 0
end


git add -A
git commit -m "$message"
