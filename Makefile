DOT := $$HOME/.dotfiles

oh-my-zsh:
	git --work-tree ${DOT} submodule init
	git --work-tree ${DOT} submodule update zsh/oh-my

brew:
	brew install safe-rm
	brew install diff-so-fancy
	brew install zsh zsh-completions
	brew install trash git
	brew install trash zsh
cask:
	brew cask install atom --appdir ~/Applications

gem:
	gem install --http-proxy $(ALL_PROXY) hirb colorize overcommit 

atom-packages:
	apm install --production --packages-file ~/.dotfiles/atom/packages.txt

bundle:
	brew bundle install --file ~/.dotfiles/Brewfile

symlink:
	$(foreach file, $(shell ls $(THIS)/symlinks), ln -fs $(THIS)/symlinks/$(file) $(HOME)/.$(file);)
