#!/usr/bin/env bash

if [ -z "$bootstrap" ]; then
    echo "This file is not intended to be called directly."
    exit 1
fi

function deploy() {
    echo "Copying files to your home directory."

    # I prefer to be prudent, blacklist everything and only rsync certain files.
    # This is achieved in 4 stages (the order does matter, so whitelist your files only inside stage 3:
    #
    # stage 1) exclude .*/      - don't sync hidden directories (like .git)
    # stage 2) include */       - do sync entire directory structure, but no files for now
    #
    #
    # stage 3.1) include file_1 - do sync whitelisted file_1 (repeat this for each file you want to sync)
    # stage 3.2) include file_2 - do sync whitelisted file_2 (repeat this for each file you want to sync)
    #
    #
    # stage 4) exclude *        - exclude everything else

    rsync \
        -ah \
        --no-perms \
        \
        --exclude=".*/" \
        --include="*/" \
        \
        \
        --include="file1" \
        --include="file2" \
        \
        \
        --exclude="*" \
        . ~

    echo "Files copied."
}
