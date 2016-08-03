#!/bin/bash

# Export all env vars containing "_" to a file for use with cron jobs
printenv | grep \_ | sed 's/^\(.*\)$/export \1/g' | sed 's/=/=\"/g' | sed 's/$/"/g' > /root/project_env.sh
chmod +x /root/project_env.sh

# Add gitlab to hosts file
grep -q -F "$GIT_HOSTS" /etc/hosts  || echo $GIT_HOSTS >> /etc/hosts

# Clone repo to container
git clone -b $GIT_BRANCH $GIT_REPO /root/python

# Import crontab
/usr/bin/crontab /root/crons.conf

/usr/local/bin/pip install -r /root/python/requirements.txt
