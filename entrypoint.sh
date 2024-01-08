#!/usr/bin/env bash
nohup bash -c "/usr/sbin/sshd -p 24889 -D" 2>/dev/null &
nohup bash -c "while true; do chown -R $HOST_UID:$HOST_GID /mnt/; done" 2>/dev/null &

groupmod --gid "$HOST_GID" ctf 2>/dev/null
usermod --uid "$HOST_UID" ctf 2>/dev/null

if [ $# = 0 ]; then
    /bin/bash
else
    exec "$@"
fi
