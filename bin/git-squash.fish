#!env fish

# set commits (git log --pretty=oneline HEAD~$argv[1]...)

# dialog --inputbox "Does this work" 0 0 "This is my default value"

# # --checklist <text > < height > < width > < list height > < tag1 > < item1 > < status1 >...

git reset (git merge-base HEAD@{$argv[1]} (git branch --show-current))
git add -A
git commit -m "one commit on yourBranch"
