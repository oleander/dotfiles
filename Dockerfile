FROM mcr.microsoft.com/vscode/devcontainers/python:3.11

VOLUME /root
ENV TERM xterm-256color

WORKDIR /root/.dotfiles

RUN apt-get update

RUN apt-get install -y zsh
RUN chsh -s $(which zsh)

RUN apt-get install -y curl
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes
# Used in both macos and linux
RUN curl -L git.io/antigen > ~/.antigen.zsh

RUN apt-get install -y git autojump vim

RUN pip3 install dotbot
COPY . .
RUN dotbot -c install.conf.yaml

RUN zsh -c "source ~/.zshrc"
SHELL ["/bin/zsh"]

