#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# get settings
NETID=$(python3 $DIR/bash_brains.py nyu_net_id)
echo "NET ID: $NETID"

# get server name
HOSTNAME=$(python3 $DIR/bash_brains.py hostname)
echo "HOSTNAME: $HOSTNAME"

# server directory in which to upload
TARGETDIR="~/public_html/continuous-deployment"

# upload files to server
rsync -avz ./* $NETID@$HOSTNAME:$TARGETDIR
