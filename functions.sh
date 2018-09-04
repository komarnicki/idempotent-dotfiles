#!/usr/bin/env bash

if [ -z "$bootstrap" ]; then
    echo "This file is not intended to be called directly."
    exit 1
fi

function deploy() {
    source .do_macos
    source .do_ssh
    source .do_sublime_text
}
