#!/usr/bin/env bash

if [ -z "$bootstrap" ]; then
    echo "This file is not intended to be called directly."
    exit 1
fi

source helpers.sh

# This is the main method invoked by the bootstrap file.
# It triggers particular function that adjust specific areas of the system.
function deploy() {
    copy_files_to_home_directory
    adjust_ssh_directory
    adjust_macos

    success "All done 🍺"
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
        --exclude="LICENSE" \
        --exclude="README.md" \
        . ~

    success "Done"
}

function adjust_ssh_directory() {
    echo "Adjusting .ssh directory."
    mkdir -p ~/.ssh/sockets

    success "Done"
}

function adjust_macos() {
    path=~/.macos/.macos.sh

    if [ -f ${path} ]; then
        echo "Adjusting macOS settings."
        sh ${path}
        success "Done"
    else
        error "Unable to find ${path}"
        error "Skipping this step"
    fi
}
