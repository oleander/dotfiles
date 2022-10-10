#!env fish

if not set -q argv[1]
    echo "Usage: gm <commit message>"
    exit 1
end

git commit -m $argv
