deploy host:
    ./deploy/deploy {{host}}
restart-ssh-addon:
    id=$(just ssh-addon-id)
    ssh homeassistant ha addon restart $id
    open https://ha.oleander.io/hassio/addon/$id/logs
ssh-addon-id:
    ssh homeassistant ha addons --raw-json | jq '.data.addons[] | select(.name == "Advanced SSH & Web Terminal") | .slug'
