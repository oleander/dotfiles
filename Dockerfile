FROM mcr.microsoft.com/vscode/devcontainers/base:latest

VOLUME /root

WORKDIR /root/.dotfiles

COPY . .
RUN ./install.sh

SHELL ["/bin/zsh", "-i", "-c"]

