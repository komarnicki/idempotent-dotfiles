#!/usr/bin/env bash

if [ -z "$bootstrap" ]; then
    echo "This file is not intended to be called directly."
    exit 1
fi

source helpers.sh

function copy_files_to_home_directory() {
    echo "Copying files to your home directory."

    rsync \
        -ah \
        --no-perms \
        --exclude=".git" \
        --exclude=".gitignore" \
        --exclude="bootstrap.sh" \
        --exclude="functions.sh" \
        --exclude="LICENSE" \
        --exclude="README.md" \
        . ~

    success "Done"
}

function set_ssh_directory() {
    echo "Setting up .ssh directory."
    mkdir -p ~/.ssh/sockets

    success "Done"
}

function deploy() {
    copy_files_to_home_directory
    set_ssh_directory

    success "All done 🍺"
}
