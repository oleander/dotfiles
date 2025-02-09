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
macos-simulator:
    docker build -f Dockerfile.macos -t macos-dotfiles . && docker run -it macos-dotfiles
homeassistant:
    docker build -f Dockerfile -t homeassistant-dotfiles . && docker run -it homeassistant-dotfiles
