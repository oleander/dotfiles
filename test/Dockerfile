FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    git \
    openssh-client \
    zsh \
    curl \
    python3 \
    python3-pip \
    python3-yaml \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create test user and add to sudo
RUN useradd -m -s /bin/zsh testuser && \
    echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to test user
USER testuser
WORKDIR /home/testuser

# Set environment variables
ENV HOME=/home/testuser \
    OS=linux \
    PATH="/home/testuser/.local/bin:${PATH}"

# Create necessary directories with correct permissions
RUN mkdir -p ~/.ssh ~/.config ~/.local/bin && \
    chmod 700 ~/.ssh

# Configure git for the test user
RUN git config --global user.email "test@example.com" && \
    git config --global user.name "Test User" && \
    git config --global init.defaultBranch main
