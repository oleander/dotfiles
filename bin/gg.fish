#!env fish

if not set -q argv[1]
  echo "Usage: gg <commit message>"
  exit 1
end

git add -A
git commit -m "$argv"
