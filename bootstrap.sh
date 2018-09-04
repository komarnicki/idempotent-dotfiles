#!/usr/bin/env bash

# Export variable with a non-zero length value
# so that it can be used to prevent from executing
# partial files directly
export bootstrap=1

# Go to the directory of the bootstrap script
cd "$(dirname "${BASH_SOURCE}")"

# Ask for the administrator's password
sudo -v

# Update existing sudo timestamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

source helpers.sh
source functions.sh

should_pull=true
should_force=false

# Adjust certain flags based on given arguments
for arg in "$@"
do
    if [ "$arg" == "--no-update" ]; then
        should_pull=false
    fi

    if [ "$arg" == "--force" ] || [ "$arg" == "-f" ]; then
        should_force=true
    fi
done

# Keep everything up to date if possible
if [ "$should_pull" = true ]; then
    git pull origin master
fi

# Deploy the dotfiles
if [ "$should_force" = true ]; then
    deploy
else
    printf "Running this script will override certain files in your home directory.\n"
    read -p "Do you want to proceed? [y/N] " response

    if [ "$response" == "Y" ] || [ "$response" == "y" ]; then
        deploy
    else
        printf "Nothing happened\n"
    fi
fi

unset -f deploy
