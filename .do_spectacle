#!/usr/bin/env bash

if [ -z "$bootstrap" ]; then
    echo "This file is not intended to be called directly."
    exit 1
fi

task_start "Spectacle: Copy keyboard shortcuts file"
mkdir -p ~/Library/Application\ Support/Spectacle
cp -r spectacle/Shortcuts.json ~/Library/Application\ Support/Spectacle/Shortcuts.json
task_stop

killall "Spectacle" &> /dev/null
open -a "Spectacle" &> /dev/null
