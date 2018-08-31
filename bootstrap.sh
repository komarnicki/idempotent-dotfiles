#!/usr/bin/env bash

# Export variable with a non-zero length value
# so that it can be used to prevent from executing
# partial files directly
export bootstrap=1

# Go to the directory of the bootstrap script
cd "$(dirname "${BASH_SOURCE}")"

source functions.sh

should_pull=true
should_force=false

# Adjust certain flags based on given arguments
for arg in "$@"
do
    if [ "$arg" == "--no-update" ]; then
        should_pull=false
        warning "The '--no-update' flag detected. Pull from origin master skipped."
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
    echo "Running this script will override certain files in your home directory."
    read -p "Do you want to proceed? [y/N] " response

    if [ "$response" == "Y" ] || [ "$response" == "y" ]; then
        deploy
    else
        success "Nothing happened"
    fi
fi

unset -f deploy
