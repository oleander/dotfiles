#!/usr/bin/env fish

function gm --description "Git merge with branch selection assistance"
    if count $argv > /dev/null
        git merge $argv
        return
    end
    
    # If no branch specified, show a list of branches to choose from
    set -l branches (git branch --no-color | grep -v '^*' | sed 's/^  //')
    
    if test (count $branches) -eq 0
        echo "No other branches to merge"
        return 1
    end
    
    # Print branches with numbers
    for i in (seq (count $branches))
        echo "$i) $branches[$i]"
    end
    
    # Ask for selection
    echo -n "Enter branch number to merge (or 'q' to quit): "
    read -l choice
    
    if test "$choice" = "q"
        echo "Merge cancelled"
        return 0
    end
    
    if test "$choice" -gt 0 -a "$choice" -le (count $branches)
        set -l selected_branch $branches[$choice]
        echo "Merging branch '$selected_branch'..."
        git merge $selected_branch
    else
        echo "Invalid selection"
        return 1
    end
end