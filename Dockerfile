FROM mcr.microsoft.com/vscode/devcontainers/python:3.11

VOLUME ["/workspace"]
WORKDIR /root/.dotfiles

COPY . .
RUN ./scripts/linux.sh

SHELL ["/bin/zsh"]
