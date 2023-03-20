#!env fish

if not set -q argv[1]
    echo "Usage: gm <commit message>"
    exit 1
end

# Move all arguments to a single string
set message $argv

# Ensure the first character is uppercase
set message (echo $message | sed 's/^\(.\)/\u\1/')

# Prefix the current name of the branch if the branch makes the following expression ABC-123
set branch (git rev-parse --abbrev-ref HEAD)
if echo $branch | grep -q -E '^[A-Z]+-[0-9]+$'
    set message "$branch $message"
end

git commit -m $message
