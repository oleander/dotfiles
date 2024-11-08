install:
    dotbot -c install.conf.yaml
dump:
    brew bundle dump --cleanup --all
install-vim-plug:
    curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
install-brew:
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
brew-bundle:
    brew bundle install
rvm-install:
    curl -sSL https://get.rvm.io | bash -s stable
    rbenv install latest && rbenv init
install-oh-my-zsh:
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
brew-bundle-install:
    brew bundle --clean --all
build:
    docker build -t dotfiles .
run: build
    docker run -it --rm -v "$(pwd)":/workspace dotfiles zsh
