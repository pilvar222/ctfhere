#!/usr/bin/env bash
nohup bash -c "/usr/sbin/sshd -p 24889 -D" 2>/dev/null &
nohup bash -c "while true; do sleep 0.1 && chown -R $HOST_UID:$HOST_GID /mnt/; done" 2>/dev/null &
sleep 0.1 && rm /mnt/nohup.out

groupmod --gid "$HOST_GID" ctf 1>/dev/null
usermod --uid "$HOST_UID" ctf 1>/dev/null

if [ $# = 0 ]; then
    /bin/bash
else
    exec "$@"
fi
