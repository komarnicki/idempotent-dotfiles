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

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

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
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true
#defaults delete NSDisableAutomaticTermination # reset

# Disable Crash Reporter
defaults write com.apple.CrashReporter DialogType -string "none"
#defaults write com.apple.CrashReporter DialogType crashreport # reset

# Empty the content of ~/Library/Logs directory but not the directory itself
# It's safe to remove the content of this directory since it contains only logs
# After some time, it may consume a significant amount of disk space
sudo rm -rf ~/Library/Logs/*

# Show IP address, hostname and OS version when clicking the clock in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
#sudo defaults delete /Library/Preferences/com.apple.loginwindow AdminHostInfo # reset

# Disable automatic spelling
# System Preferences -> Keyboard -> Text -> Correct spelling automatically
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable automatic capitalization
# System Preferences -> Keyboard -> Text -> Capitalize words automatically
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes, period substitution and smart quotes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Set a solid black colour as background wallpaper on every display currently connected
cp ./solid_black_wallpaper.png ~/Pictures/solid_black_wallpaper.png
osascript -e 'tell application "System Events" to tell every desktop to set picture to "~/Pictures/solid_black_wallpaper.png"'

# Set keyboard repeat speed
# System Preferences -> Keyboard -> Keyboard
# Default GUI values for KeyRepeat are: 120, 90, 60, 30, 12, 6, 2 (lower value, faster speed)
# Default GUI values for InitialKeyRepeat are: 120, 94, 68, 35, 25, 15 (lower value, faster speed)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Language and text format
defaults write NSGlobalDomain AppleLanguages -array "en" "pl"
defaults write NSGlobalDomain AppleLocale -string "en_AU@currency=AUD" # "en_PL@currency=PLN"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

killall Dock
