#!/bin/bash
set -e

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
trap "echo TRAPed signal" HUP INT QUIT KILL TERM

echo "mirror ssh keys to keys"
eval "$(ssh-agent -s)"
ssh-add /keys/id_rsa
ssh -o StrictHostKeyChecking=no -T git@github.com > /dev/null &

if [ "$1" = 'couchdb' ]; then
    echo "start CouchDB"
    exec "/usr/local/bin/couchdb" > /dev/null &
fi

if [ "$2" = 'bash' ]; then
    echo "start bash"
    exec bash
fi

