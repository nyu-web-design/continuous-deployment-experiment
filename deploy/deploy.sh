#!/usr/bin/env bash

# the directory that houses this file
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# get settings
NETID=$(python3 $DIR/bash_brains.py nyu_net_id)
echo "NET ID: $NETID"

# get server name
HOSTNAME=$(python3 $DIR/bash_brains.py hostname)
echo "HOSTNAME: $HOSTNAME"

# server directory in which to upload
DESTINATIONDIR==$(python3 $DIR/bash_brains.py destination_dir)
echo "DESTINATION DIR: $DESTINATIONDIR"

if [ $# -eq 0 ]
  then
    # running from local machine...
    # upload files to server using local machine's default SSH keys
    rsync -avz ./* $NETID@$HOSTNAME:$DESTINATIONDIR 
  else
    # running from GitHub build server...
    # get the file path to SSH private key file from command line argument
    $SSHIDFILEPATH=$1
    echo "IDENTIFY FILE: $SSHIDFILEPATH"

    # upload files to server using this SSH private key file
    rsync -avz -e 'ssh -i $SSHIDFILEPATH $NETID@$HOSTNAME:$DESTINATIONDIR StrictHostKeyChecking=no' ./* $NETID@$HOSTNAME:$DESTINATIONDIR
fi

