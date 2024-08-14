#!/usr/bin/env fish

set model gpt-4o
set temp 0.0

function prompt
    fabric -p "$argv[1]" -m "$model" --temp "$temp"
end

# remoce ```markdown from first line
# and remove ``` from the last line
# trim whitespaces
function strip
    sed -e '1s/^```markdown//' | sed -e '$s/```$//' | sed -e 's/^[ \t]*//'
end

echo "Generating PR title and body..."
git diff main...HEAD | prompt write_pull-request | strip | gh pr edit --body-file - >/dev/null
gh pr view --json body | jq -r '.body' | prompt generate-pr-title | xargs -I {} gh pr edit --title "{}"
