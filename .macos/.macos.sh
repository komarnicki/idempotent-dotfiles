#!/usr/bin/env bash

if [ -z "$bootstrap" ]; then
    echo "This file is not intended to be called directly."
    exit 1
fi

# Quit System Preferences window if present
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator's password
sudo -v

# Update existing sudo timestamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

################################################################################

# Disable the boot sound effect
sudo nvram SystemAudioVolume=" "
#sudo nvram -d SystemAudioVolume # reset

# Reduce transparency
# System Preferences -> Accessibility -> Display -> Reduce transparency
defaults write com.apple.universalaccess reduceTransparency -bool true
#
# Set highlight color to blue (HEX b3dbfd / RGB 179,216,253)
# System Preferences -> General -> Highlight color
# Each decimal value is a RGB (from 0 to 255) divided by 255
defaults write NSGlobalDomain AppleHighlightColor -string "0.701960784313725 0.847058823529412 0.992156862745098"

# Set sidebar icon size to medium
# System Preferences -> General -> Sidebar icon size
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Scrollbar (possible values: "Automatic", "WhenScrolling", "Always")
# System Preferences -> General -> Show scroll bars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Disable smooth scrolling
defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false
#defaults delete com.apple.LaunchServices LSQuarantine # reset

# Remove duplicate items from "Open With" menu
# As a negative side effect, bunch of app icons may be temporarily gone and show a generic one
#/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Disable Automatic Termination
defaults write -g NSDisableAutomaticTermination -bool yes
#defaults delete NSDisableAutomaticTermination # reset

# Disable Crash Reporter
defaults write com.apple.CrashReporter DialogType -string "none"
#defaults write com.apple.CrashReporter DialogType crashreport # reset

# Empty the content of ~/Library/Logs directory but not the directory itself
# It's safe to remove the content of this directory since it contains only logs
# After some time, it may consume a significant amount of disk space
sudo rm -rf ~/Library/Logs/*

killall Dock
