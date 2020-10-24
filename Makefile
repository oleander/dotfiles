DOT := $$HOME/.dotfiles

oh-my-zsh:
	git --work-tree ${DOT} submodule init
	git --work-tree ${DOT} submodule update zsh/oh-my

brew:
	brew install safe-rm
	brew install diff-so-fancy
	brew install zsh zsh-completions
	brew install git zsh
cask:
	brew cask install atom --appdir ~/Applications

gem:
	gem install --http-proxy $(ALL_PROXY) hirb colorize overcommit

npm:
	npm install -g trash-cli

atom:
	cp --update -f --remove-destination --symbolic-link atom/* ~/.atom
	apm install --production --packages-file atom/packages.txt

bundle:
	brew bundle install --file ~/.dotfiles/Brewfile

git:
	git config --global --add url."git@github.com:".insteadOf "https://github.com/"

symlink:
	$(foreach file, $(shell ls $(THIS)/symlinks), ln -fs $(THIS)/symlinks/$(file) $(HOME)/.$(file);)
	ln -fsr atom ~/.atom
	ln -fsr rake ~/.rake
