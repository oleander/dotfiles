FROM mcr.microsoft.com/devcontainers/python:bullseye

ADD https://starship.rs/install.sh /tmp/install-starship.sh
RUN chmod +x /tmp/install-starship.sh
RUN /tmp/install-starship.sh -y

# test for install.conf.yaml
COPY install.conf.yaml .
RUN git init
RUN git submodule add https://github.com/anishathalye/dotbot
RUN git config -f .gitmodules submodule.dotbot.ignore dirty
RUN git submodule update --init --remote || git submodule update --init --remote
RUN cp dotbot/tools/git-submodule/install dot && ./dot -c ./install.conf.yaml

# Verification steps for the devcontainer setup
RUN if [ ! -f /workspace/.config/fish/config.fish ]; then echo "Expected file /workspace/.config/fish/config.fish is missing" && exit 1; fi
RUN if [ ! -f /workspace/.config/nvim/init.vim ]; then echo "Expected file /workspace/.config/nvim/init.vim is missing" && exit 1; fi
RUN if [ ! -f /workspace/.zshrc ]; then echo "Expected file /workspace/.zshrc is missing" && exit 1; fi

WORKDIR /workspace
