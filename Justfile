install:
    dotbot -c install.conf.yaml
dump:
    brew bundle dump --cleanup --all
brew-bundle:
    brew bundle install
brew-bundle-install:
    brew bundle --clean --all
devcontainer:
    devcontainer build --buildkit auto --workspace-folder .
deploy host:
    ./deploy/deploy {{host}}
