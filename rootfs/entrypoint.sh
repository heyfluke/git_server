#!/bin/sh

chown -R git:git /home/git/.ssh 
chmod 700 -R /home/git/.ssh

# generate host keys if not present
ssh-keygen -A

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"
