FROM mcr.microsoft.com/vscode/devcontainers/python:latest

VOLUME /root

WORKDIR /root/.dotfiles

COPY . .
RUN ./install.sh

SHELL ["/bin/zsh", "-i", "-c"]

