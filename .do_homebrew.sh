#!/usr/bin/env bash

if [ -z "$bootstrap" ]; then
    echo "This file is not intended to be called directly."
    exit 1
fi

task_start "Homebrew: Install itself"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
task_stop

task_start "Homebrew: Install applications"
brew reinstall composer
task_stop

task_start "Homebrew: Install cask applications"
brew cask reinstall spectacle
task_stop
