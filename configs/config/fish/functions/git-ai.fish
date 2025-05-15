function git-ai --description "Git helper with AI assistance"
    set -l cmd $argv[1]
    set -l args $argv[2..-1]
    
    if test "$cmd" = "commit" -o "$cmd" = "c"
        # Generate commit message with AI
        gh copilot suggest -t git "Write a concise commit message for:" (git diff --staged)
    else if test "$cmd" = "help" -o "$cmd" = "h" -o "$cmd" = ""
        echo "git-ai - Git helper with AI assistance"
        echo ""
        echo "Usage:"
        echo "  git-ai commit (or c)   - Generate commit message based on staged changes"
        echo "  git-ai pr (or p)       - Generate PR description"
        echo "  git-ai explain (or e)  - Explain the current changes"
        echo "  git-ai help (or h)     - Show this help message"
        echo ""
    else if test "$cmd" = "pr" -o "$cmd" = "p"
        # Generate PR description with AI
        echo "Generating PR description..."
        set -l branch (git branch --show-current)
        set -l diff (git diff main...$branch)
        gh copilot suggest "Write a concise PR description for:" "$diff"
    else if test "$cmd" = "explain" -o "$cmd" = "e"
        # Explain the current changes
        echo "Explaining current changes..."
        gh copilot explain (git diff)
    else
        echo "Unknown command: $cmd"
        echo "Run 'git-ai help' for usage information."
        return 1
    end
end