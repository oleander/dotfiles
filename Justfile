install:
    dotbot -c install.conf.yaml
dump:
    brew bundle dump --cleanup --all
install-vim-plug:
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
