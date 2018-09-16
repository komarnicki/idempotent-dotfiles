#!/usr/bin/env bash

if [ -z "$bootstrap" ]; then
    echo "This file is not intended to be called directly."
    exit 1
fi

function deploy() {
    source .do_macos.sh
    source .do_ssh.sh
    source .do_homebrew.sh
    source .do_spectacle.sh
    source .do_sublime_text.sh
}
