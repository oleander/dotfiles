if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# Using Ruby 1.9.2 as default
# rvm user 1.9.2 --default does not seams to work
rvm use 1.9.2 >> /dev/null

# Jumping to the project directory
# Only if we are at the home directory (== new tab was open)
if [ "$HOME" == "$PWD" ]; then cr; fi