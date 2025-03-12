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
