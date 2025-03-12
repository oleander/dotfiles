deploy host: commit-and-push
    ./deploy/deploy {{host}}
restart-ssh-addon: commit-and-push
    open "https://ha.oleander.io/hassio/addon/a0d7b954_ssh/logs"
    ssh homeassistant ha addon restart $(just ssh-addon-id)
ssh-addon-id:
    ssh homeassistant ha addons --raw-json | jq '.data.addons[] | select(.name == "Advanced SSH & Web Terminal") | .slug'
ssh-addon-logs:
    ssh homeassistant ha addon logs $(just ssh-addon-id)
commit-and-push:
    git commit --no-edit -a || true
    git push origin $(git rev-parse --abbrev-ref HEAD)

# Update an existing GitHub Gist with ssh-dotfiles-update.sh
update-dotfiles-gist GIST_ID:
    @echo "Updating Gist {{GIST_ID}} with ssh-dotfiles-update.sh..."
    gh gist edit {{GIST_ID}} scripts/ssh-dotfiles-update.sh

# Create a new GitHub Gist with ssh-dotfiles-update.sh
create-dotfiles-gist:
    @echo "Creating new GitHub Gist from ssh-dotfiles-update.sh..."
    gh gist create --desc "SSH Dotfiles Update Script" scripts/ssh-dotfiles-update.sh

# Ensure a GitHub Gist exists (create if not exists, update if exists)
ensure-dotfiles-gist GIST_ID="i2f6dc25201634a59189d78e457fcae55":
    #!/bin/bash
    if [ -z "{{GIST_ID}}" ]; then
        echo "No Gist ID provided, creating new Gist..."
        gh gist create --desc "SSH Dotfiles Update Script" scripts/ssh-dotfiles-update.sh
    else
        echo "Checking if Gist {{GIST_ID}} exists..."
        if gh gist view {{GIST_ID}} >/dev/null 2>&1; then
            echo "Updating existing Gist {{GIST_ID}}..."
            gh gist edit {{GIST_ID}} scripts/ssh-dotfiles-update.sh
        else
            echo "Gist {{GIST_ID}} not found, creating new Gist..."
            gh gist create --desc "SSH Dotfiles Update Script" scripts/ssh-dotfiles-update.sh
        fi
    fi
test-ssh-dotfiles-update: ensure-dotfiles-gist
    ssh mini
