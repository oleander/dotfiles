FROM mcr.microsoft.com/vscode/devcontainers/python:3.11

VOLUME /root

WORKDIR /root/.dotfiles

RUN apt-get update

RUN apt-get install -y curl zsh

RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

RUN apt-get install -y git autojump vim

RUN pip3 install dotbot
COPY . .
RUN dotbot -c install.conf.yaml

SHELL ["/bin/zsh"]

