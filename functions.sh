#!/usr/bin/env bash

if [ -z "$bootstrap" ]; then
    echo "This file is not intended to be called directly."
    exit 1
fi

function mark_as_done() {
    echo "Done."
}

function copy_files_to_home_directory() {
    echo "Copying files to your home directory."

    rsync \
        -ah \
        --no-perms \
        --exclude=".git" \
        --exclude=".gitignore" \
        --exclude="bootstrap.sh" \
        --exclude="functions.sh" \
        . ~

    mark_as_done
}

function set_ssh_directory() {
    echo "Setting up .ssh directory."

    mark_as_done
}

function deploy() {
    copy_files_to_home_directory
    set_ssh_directory
}
