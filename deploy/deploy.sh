#!/usr/bin/env bash

# the directory that houses this file
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# get settings
USERNAME=$(python3 $DIR/bash_brains.py nyu_net_id)
echo "NET ID: $NETID"

# get server name
HOSTNAME=$(python3 $DIR/bash_brains.py hostname)
echo "HOSTNAME: $HOSTNAME"

# server directory in which to upload
DESTINATIONDIR=$(python3 $DIR/bash_brains.py destination_dir)
echo "DESTINATION DIR: $DESTINATIONDIR"

# upload files to server using local machine's default SSH keys
rsync -avz ./* $USERNAME@$HOSTNAME:$DESTINATIONDIR 
