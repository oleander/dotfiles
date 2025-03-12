deploy host:
    ./deploy/deploy {{host}}
restart-ssh-addon:
    open "https://ha.oleander.io/hassio/addon/a0d7b954_ssh/logs"
    ssh homeassistant ha addon restart $(just ssh-addon-id)
ssh-addon-id:
    ssh homeassistant ha addons --raw-json | jq '.data.addons[] | select(.name == "Advanced SSH & Web Terminal") | .slug'
