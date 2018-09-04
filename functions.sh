#!/usr/bin/env bash

if [ -z "$bootstrap" ]; then
    echo "This file is not intended to be called directly."
    exit 1
fi

function deploy() {
    set_home_directory
    set_macos
    set_ssh
}

function set_home_directory() {
    task_start "Copying specific files to your home directory"
    rsync \
        -ah \
        --no-perms \
        --exclude=".git" \
        --exclude=".gitignore" \
        --exclude=".do_macos" \
        --exclude=".do_ssh" \
        --exclude="bootstrap.sh" \
        --exclude="functions.sh" \
        --exclude="helpers.sh" \
        --exclude="LICENSE" \
        --exclude="README.md" \
        --exclude="solid_black_wallpaper.png" \
        . $HOME
    task_stop
}

function set_macos() {
    source .do_macos
}

function set_ssh() {
    source .do_ssh
}
