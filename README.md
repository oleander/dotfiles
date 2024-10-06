# Dotfiles

## Install

1. `just install`
2. done

## Install git-rerere

To install `git-rerere` on your MacBook Pro using Homebrew, follow these steps:

1. Open Terminal.
2. Install Git if you haven't already:
```
$ brew install git
```
3. Enable git rerere:
```
$ git config --global rerere.enabled true
```

## Test git-rerere

To test if `git-rerere` is working, follow these steps:

1. Create a test repository:
```
$ mkdir test-repo
$ cd test-repo
$ git init
```
2. Create a file and commit it:
```
$ echo "Hello, World!" > file.txt
$ git add file.txt
$ git commit -m "Initial commit"
```
3. Create a new branch and make a conflicting change:
```
$ git checkout -b new-branch
$ echo "Change in new-branch" >> file.txt
$ git commit -am "Change in new-branch"
```
4. Switch back to the main branch and make another conflicting change:
```
$ git checkout main
$ echo "Change in main" >> file.txt
$ git commit -am "Change in main"
```
5. Merge the new branch and resolve the conflict:
```
$ git merge new-branch
# Resolve the conflict manually
$ git add file.txt
$ git commit -m "Resolved conflict"
```
6. Recreate the same conflict and see if `git-rerere` automatically resolves it:
```
$ git checkout -b another-branch
$ echo "Another change in another-branch" >> file.txt
$ git commit -am "Another change in another-branch"
$ git checkout main
$ echo "Another change in main" >> file.txt
$ git commit -am "Another change in main"
$ git merge another-branch
# `git-rerere` should automatically resolve the conflict
```
