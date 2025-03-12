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
update-ssh-dotfiles-gist:
    gh gist edit https://gist.github.com/oleander/fac38e40787b4cddf1c635d062a508d5 scripts/ssh-dotfiles-update.sh
test-ssh-dotfiles-update: git-commit-and-push update-ssh-dotfiles-gist
    ssh mini exit
    ssh homeassistant exit
git-commit-and-push:
    git commit --no-edit -a || true
    git push origin $(git rev-parse --abbrev-ref HEAD)
