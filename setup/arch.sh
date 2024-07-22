#!/bin/bash

URL="git@github.com:tnek213/ansiblepull.git"
SSH_KEY_CONTENT=$(base64 -d <<< "JEFOU0lCTEVfVkFVTFQ7MS4xO0FFUzI1NgozMjM0MzgzODYxMzk2MjYyMzUzMjM4NjUzODM1MzQ2NjM2NjUzNjYyNjM2MTM3NjQ2MTYxNjEzNjM0NjIzMzYyNjI2MTYyMzQzNTMxMzkzMgozMDMxMzI2MTM4Mzc2MjYxNjQzMDMwNjMzMDY1NjE2NTM3MzQzMTM5NjY2MjY0NjMwYTMzMzIzMjMxMzk2NTMzMzI2MjYyMzMzMTMzNjM2Mgo2MjY0MzMzNjMyMzgzODY2MzY2NjYzNjEzOTMzMzA2MjMwMzkzNzM4NjUzMDM5MzQzMjY1NjQzNTYyNjQ2NDMxNjQ2NjYxNjE2MjM5MzgzNgo2MTYyMzE2MTM4MzAzNzMxMzcwYTM3MzYzMzM4MzA2NDM4MzA2MzM4MzUzMTY0MzI2NDYxMzMzOTMyNjYzNDM4MzYzNDMyMzg2MTM3NjY2NAo2NTY0NjY2NjM2Mzg2NDMzMzk2NTY1MzYzMjMxNjU2MjMxMzEzMDM5NjQzNTM5NjU2MjYzMzM2NTMxNjUzNDMwMzkzMTM2NjIzMTYzMzMzNAo2MzMxMzYzMTY0NjEzNjM4MzQzNzMyMzUzNTMzNjQ2MTMzNjYzNzYxNjEzMzM1MzgzNjM3MzE2MTYzNjI2NTY0NjUzMzM4NjIzNDM1MzU2Ngo2NDYzNjEzNTMxMzQzODM4MzYzMDYzNjIzODM1MzIzMTM4NjEzMTMyMzIzNzMzNjE2MTM1NjYzMzY0MzUzMzMxMzQ2NjM1MzUzMzYxNjYzOAozNzYzMzkzOTY1MzAzODMwMzAzNzMxMzYzNTYzMzAzNzY0MzgzNDY0MzA2MTY0MzAzOTYyMzMzMzY1NjEzNDMwMzU2MzM3MzUzNTM0MzI2Mwo2NDM5NjE2MzM1NjUzNTY2MzkzNjMwMzMzMDMyMzQzNTY0MzczMTMzMzI2MzYzMzYzMzMwMzkzNjM1MzkzMjYyMzMzMTY1MzU2MTY1MzMzMgozNTMzMzYzNDMyMzc2NTM5MzAzMTMyMzgzMzM2MzkzNjMzNjI2MzM4NjMzMTY2MzEzMDMxMzU2MjMyNjYzMTYzNjIzMDYxNjQzNDM3NjU2MgozNDMzNjU2MTM0MzkzNDYzMzQzMjM4MzUzMjMzMzk2MjMxNjMzMzMwNjQzODM1MzMzMDM3NjQ2NjM4NjUzMzM2MzkzNTM2MzA2MTMwMzY2Ngo2NDMxMzMzMDMzMzczNTYyMzA2MTMwMzAzNDYxMzEzMTMwNjYzMjM2MzUzMjM0MzczOTMwMzg2NjM2NjQzMzMzNjMzMjY0NjQzMjMyMzQzMAo2MTMxNjIzNTMxMzEzMDMyNjQ2MzYzMzUzMjY2NjQ2NjYxMzIzMjYzMzEzNjY1NjIzOTY0NjUzMzM0NjY2MzM3NjIzMjM3MzEzNjY1MzAzOAozMTM0MzIzMTYyMzYzMjYyMzAzNDM5MzM2MzMxMzc2NjM3MzMzNDM3NjQzOTY2NjIzNjM1NjQ2NDYxNjUzMDMwNjYzNzYxNjY2NDM4NjIzNQo2MzYxMzc2NDM5MzE2MzMwMzgzMzM2MzkzMzM1NjE2MTM0MzMzNzMwMzg2NjY1MzQzMTY1MzI2MjYyMzEzMTYxMzI2NTMxMzA2MzM5Mzk2NgozMjY2NjMzNjYyMzIzNTYxMzc2NDY2NjI2NTMwNjQ2NDM4NjEzNDM2MzYzODM5NjQzODMzMzA2MzMwMzEzODM0MzU2MTM4MzY2NDMzMzc2NgozNTYxMzIzODY1MzU2NjYxNjUzMDYyMzIzNzMwMzE2NDYyMzk2MjMwMzkzNDYyMzczNjYyMzYzMjM4NjUzNjM0MzMzODYzMzQzNjMxNjM2NAozNDM0Mzc2NTMyMzMzNzM4MzUzNjM5NjEzNzM4MzQ2NTYyMzA2MTM3NjUzMjM4MzI2MTY1MzQzNzM3MzI2MjM4NjY2NTM5NjYzMTY2MzUzOQozNjM5MzczNTYxNjQzNjM0MzczNjYyMzIzOTMxMzMzMDM0MzMzMjMzNjEzMDY2MzgzNzY1MzQzMzYzNjUzNTYxMzIzMDY2MzgzMTM5MzMzNgo2NTM2MzMzNDM5MzMzOTYxNjMzNzMzMzY2MzM0MzMzMDMwMzEzMjM2MzMzMDYzNjQzMTY0NjEzNTMyMzQzNzMyNjMzNzY0NjM2MjM4MzA2NQozNjMwMzEzMzYzNjE2MzMwMzEzNDMwNjYzNjY2NjEzNDM4MzM2MTM1MzQ2MTM1MzI2MTM4NjQzOTMyMzQzMzM3MzEzMTMzMzEzMDYzNjQzMwo2NjMxNjMzNjMxMzQzOTYyMzY2MTMzNjM2NDY2NjM2MzM0NjMzOTMwMzczMTYyNjMzMTYxMzkzMDM0MzIzNDYxNjIzMzMyMzUzMjMwMzUzMAozNjM0NjIzOTM2NjYzMTMyNjI2NTMxMzczMzY2MzQzOTMxNjYzMTM2NjI2NjY2MzkzOTM3MzQzNjYxMzIzMDMxMzEzOTY1MzMzMjY1MzMzOAozOTM3NjIzMTY0NjMzMzM0MzkzMwo=")
SSH_KEY_PUB_CONTENT=$(base64 -d <<< "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSVBLakVzNjZuT0xXdkpaMUxvME9tOGVIdUMyZkh1RGNCSUJqTlBNSGMyYW0gYW5zaWJsZXB1bGwK")

set -euo pipefail

pacman --needed --noconfirm -S ansible git openssh

DIR=$(mktemp -d)
# shellcheck disable=SC2064
trap "rm -rf \"$DIR\"" EXIT

KEY="$DIR/key"
KEY_PUB="$DIR/key.pub"
SSH_CONFIG="$DIR/ssh_config"
VAULT="$DIR/vault"

cd "$DIR"

(
    umask 066
    echo "$SSH_KEY_CONTENT" > "$KEY"
    echo "$SSH_KEY_PUB_CONTENT" > "$KEY_PUB"

    cat <<EOF > "$SSH_CONFIG"
Host github.com
    HostName github.com
    User git
    IdentityFile "$KEY"
    IdentitiesOnly yes
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
EOF
)

if [ -e /tmp/vault ] && [ -n "${DEBUG:-}" ]
then
    mv /tmp/vault "$VAULT"
fi

RETRY=

while true
do
    if ! [[ -f "$VAULT" && -z $RETRY ]]
    then
        read -rsp "Enter the vault password: " PASSWORD
        echo "$PASSWORD" > "$VAULT"
    fi

    if ansible-vault decrypt "$KEY" --vault-password-file "$VAULT"
    then
        ( umask 066 && cp "$VAULT" /tmp/vault )
        break
    else
        RETRY=true
        echo "Invalid password. Try again."
    fi
done

export GIT_SSH_COMMAND="ssh -F '$SSH_CONFIG'"

git clone --depth 1 "$URL" checkout

cd checkout

export ANSIBLE_HOME=/tmp

ansible-playbook \
    --vault-password-file "$VAULT" \
    --inventory "./inventory.yml" \
    --extra-vars "arg_key=$KEY arg_key_pub=$KEY_PUB arg_vault=$VAULT" \
    setup.yml
