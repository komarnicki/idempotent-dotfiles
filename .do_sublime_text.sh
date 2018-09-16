#!/usr/bin/env bash

if [ -z "$bootstrap" ]; then
    echo "This file is not intended to be called directly."
    exit 1
fi

mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

task_start "Sublime Text 3: Copy settings"
cp -r sublime_text/Preferences.sublime-settings \
    ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
task_stop

task_start "Sublime Text 3: Install plugins"
cp -r sublime_text/plugins/Shell-Unix-Generic.sublime-settings \
    ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/Shell-Unix-Generic.sublime-settings
task_stop

task_start "Sublime Text 3: Copy Key Bindings"
cp -r sublime_text/Default\ \(OSX\).sublime-keymap \
    ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Default\ \(OSX\).sublime-keymap
task_stop

killall "Sublime Text" &> /dev/null
