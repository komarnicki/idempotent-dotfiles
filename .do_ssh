#!/usr/bin/env bash

if [ -z "$bootstrap" ]; then
    echo "This file is not intended to be called directly."
    exit 1
fi

# Make sure the .ssh exists in user's home directory
mkdir -p ~/.ssh/

task_start "SSH: Copy configuration file"
cp -r ssh/config ~/.ssh/config
task_stop

task_start "SSH: Create place for sockets"
mkdir -p ~/.ssh/sockets
task_stop
