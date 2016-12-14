DOTDIR := $$HOME/.dotfiles
CLEAN_CMD := rm -fr $(DOTDIR)
CLONE_CMD := git clone https://github.com/oleander/dotfiles $(DOTDIR)
INSTALL_CMD := $(CLEAN_CMD) && $(CLONE_CMD) && cd $(DOTDIR) && make update
THIS=$(shell pwd)

deploy: git_push deploy_atlantic deploy_ocean deploy_local

deploy_ocean:
	@ssh ocean 'cd $(DOTDIR) && make update'
deploy_atlantic:
	@ssh atlantic 'cd $(DOTDIR) && make update'
deploy_local: update_submodule symlink
	@exec bin/reload

install_atlantic:
	@ssh atlantic '$(INSTALL_CMD)'
install_ocean:
	@ssh ocean '$(INSTALL_CMD)'
install_local: clean_local symlink_dotfiles_local update_submodule symlink
	@exec bin/reload

install_linux_deps:
	apt-get install safe-rm
	apt-get install diff-so-fancy
install_osx_deps:
	brew install safe-rm
	brew install diff-so-fancy
	npm install -g how2
	brew install zsh zsh-completions

clean_local:
	@exec $(CLEAN_CMD)
symlink_dotfiles_local:
	@ln -fs $(THIS) $(DOTDIR)
symlink:
	ln -fsT $(THIS) $(DOTDIR)
	$(foreach file, $(shell ls $(THIS)/symlinks), ln -fs $(THIS)/symlinks/$(file) $(HOME)/.$(file);)
	ln -fs $(THIS)/atom $(HOME)/.atom

update: update_git symlink
update_git: update_submodule
	@git stash
	@git fetch --all
	@git reset --merge --hard origin/master
update_submodule:
	@git submodule init
	@git submodule update zsh/oh-my
git_push:
	git push
