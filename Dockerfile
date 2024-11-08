FROM mcr.microsoft.com/vscode/devcontainers/python:3.11

VOLUME /root

WORKDIR /root/.dotfiles

COPY . .
RUN ./install.sh

SHELL ["/bin/zsh", "-i", "-c"]

