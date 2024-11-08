FROM mcr.microsoft.com/vscode/devcontainers/python:3.11

VOLUME ["/workspace"]
WORKDIR /root/.dotfiles

COPY ./scripts/linux.sh ./install.conf.yaml .
RUN ./scripts/linux.sh

VOLUME /root

SHELL ["/bin/zsh"]
