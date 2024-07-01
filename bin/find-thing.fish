#!/usr/bin/env fish

# Get the current working directory
set pwd_dir (pwd)

# Iterate over all directories in the current directory
for dir in (find . -maxdepth 1 -type d -not -name '.')
    set full_dir "$pwd_dir/$dir"
    echo "Checking directory: $full_dir"
    
    # Change to the directory
    cd $full_dir
    
    # Check if it's a git repository
    if test -d .git
        echo "Directory $full_dir is a git repository"
        
        # Save the current branch to return to it later
        set original_branch (git branch --show-current)
        
        # Iterate over all branches
        for branch in (git for-each-ref --format='%(refname:short)' refs/heads/)
            echo "  Checking branch: $branch"
            
            # Checkout the branch
            git checkout $branch > /dev/null 2>&1
            
            # Get the commit history
            set commits (git log --pretty=format:"%H")
            
            for commit in $commits
                # Checkout the commit
                git checkout $commit > /dev/null 2>&1
                
                # Use ag to search for "td.frei" and "test" in src/main.rs
                if ag "td.frei" --rs > /dev/null
                    if ag "test" --rs > /dev/null
                        echo "  Found in branch $branch at commit $commit in src/main.rs"
                        break
                    end
                end
            end
        end
        
        # Checkout back to the original branch
        git checkout $original_branch > /dev/null 2>&1
    else
        echo "Directory $full_dir is not a git repository"
    end
    
    # Change back to the parent directory
    cd $pwd_dir
end

