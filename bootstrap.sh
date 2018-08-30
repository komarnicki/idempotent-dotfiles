#!/usr/bin/env bash

# Export variable with a non-zero length value
# so that it can be used to prevent from executing
# partial files directly
export bootstrap=1

# Go to the directory of the bootstrap script
cd "$(dirname "${BASH_SOURCE}")"

source functions.sh

# Keep everything up to date
#git pull origin master

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
    deploy
else
    echo "Running this script will override certain files in your home directory."
    read -p "Do you want to proceed? [y/N]" response

    if [ "$response" == "Y" ] || [ "$response" == "y" ]; then
        deploy
    else
        # Explicitly indicate that nothing has been done
        echo "Nothing happened."
    fi
fi

unset -f deploy
