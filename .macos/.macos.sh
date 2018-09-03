#!/usr/bin/env bash

if [ -z "$bootstrap" ]; then
    echo "This file is not intended to be called directly."
    exit 1
fi

# Quit System Preferences window if present to prevent anny accidental settings chance
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator's password
sudo -v

# Update existing sudo timestamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#-------------------------------------------------------------------------------
# Low level system settings
#-------------------------------------------------------------------------------

# Disable the boot sound effect
sudo nvram SystemAudioVolume=" "
#sudo nvram -d SystemAudioVolume # reset

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

#-------------------------------------------------------------------------------
# Visual appearance & general settings
#-------------------------------------------------------------------------------

# Reduce transparency
# System Preferences -> Accessibility -> Display -> Reduce transparency
defaults write com.apple.universalaccess reduceTransparency -bool true

# Enable HiDPI resolutions in Display Preference Pane
sudo defaults write /Library/Preferences/com.apple.windowserver.plist DisplayResolutionEnabled -bool true
#sudo defaults delete /Library/Preferences/com.apple.windowserver.plist DisplayResolutionEnabled # reset

# Enable subpixel font rendering on non-Apple LCDs
# Reference link: https://github.com/kevinSuttle/macOS-Defaults/issues/17
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Disable window opening and closing animation
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Set highlight color to default blue by removing AppleHighlight color
# Reference https://apple.stackexchange.com/a/188170/135508
defaults delete -g AppleHighlightColor
# System Preferences -> General -> Highlight color
# Each decimal value is a RGB (from 0 to 255) divided by 255
#defaults write NSGlobalDomain AppleHighlightColor -string "0.701960784313725 0.847058823529412 0.992156862745098"

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

# Set the timezone
sudo systemsetup -settimezone "Australia/Brisbane" > /dev/null # "Europe/Warsaw"

# Show input menu in login window
# System Preferences -> Users & Groups -> Login Options -> Show input menu in login window
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Screenshots
mkdir -p $HOME/Documents/Screenshots
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture location "$HOME/Documents/Screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

#-------------------------------------------------------------------------------
# Wallpaper
#-------------------------------------------------------------------------------

# Set a solid black colour as background wallpaper on every display currently connected
cp ./solid_black_wallpaper.png $HOME/Pictures/solid_black_wallpaper.png
osascript -e 'tell application "System Events" to tell every desktop to set picture to "~/Pictures/solid_black_wallpaper.png"'

#-------------------------------------------------------------------------------
# Keyboard
#-------------------------------------------------------------------------------

# Set keyboard repeat speed
# System Preferences -> Keyboard -> Keyboard
# Default GUI values for KeyRepeat are: 120, 90, 60, 30, 12, 6, 2 (lower value, faster speed)
# Default GUI values for InitialKeyRepeat are: 120, 94, 68, 35, 25, 15 (lower value, faster speed)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

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

# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable press-and-hold for accents
defaults write -g ApplePressAndHoldEnabled -bool false

#-------------------------------------------------------------------------------
# Mouse & Trackpad
#-------------------------------------------------------------------------------

# Enable tap to click for this user and for the login screen
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

#-------------------------------------------------------------------------------
# Regional settings
#-------------------------------------------------------------------------------

# Set language and text format
defaults write NSGlobalDomain AppleLanguages -array "en" "pl"
defaults write NSGlobalDomain AppleLocale -string "en_AU@currency=AUD" # "en_PL@currency=PLN"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

#-------------------------------------------------------------------------------
# Finder
#-------------------------------------------------------------------------------

# Disable all animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Default location for newly opened windows
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Toggle visibility of icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Show hidden files, all extensions, status bar and path bar
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Don't warn when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Use list view in all Finder windows by default
# Other view modes:
# Flwv - Cover Flow View
# Nlsv - List View
# clmv - Column View
# icnv - Icon View
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Warn before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool true

# Show /Volumes and ~/Library folders
sudo chflags nohidden /Volumes
sudo chflags nohidden ~/Library

# Expand the following File Info panes:
defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    OpenWith -bool true \
    Privileges -bool true

#-------------------------------------------------------------------------------
# Menu bar
#-------------------------------------------------------------------------------

# System Preferences -> General -> Automatically hide and show the menu bar
# On High Sierra killing Finder is not enough to see this change immediately,
# every app should be restarted for menu bar to behave correctly
defaults write NSGlobalDomain _HIHideMenuBar -bool false

#-------------------------------------------------------------------------------
# Dock
#-------------------------------------------------------------------------------

# System Preferences -> Dock
# Below command restores Dock to the default state, I don't want to use it
# but it's good to keep it as a reference
#defaults delete com.apple.dock

# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Set the icon size of Dock items
defaults write com.apple.dock tilesize -int 48

# Set minimize window effect to "scale" (other option is "genie")
defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into their application's icon
defaults write com.apple.dock minimize-to-application -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicators for open applications
defaults write com.apple.dock show-process-indicators -bool true

# Don't animate (bounce) opening applications
defaults write com.apple.dock launchanim -bool false

# Set Dock auto-hide state and delay
defaults write com.apple.dock autohide -bool false
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

#-------------------------------------------------------------------------------
# Hot corners
#-------------------------------------------------------------------------------

# Possible values:
#  0 - no-op
#  2 - Mission Control
#  3 - Show application windows
#  4 - Desktop
#  5 - Start screen saver
#  6 - Disable screen saver
#  7 - Dashboard
# 10 - Put display to sleep
# 11 - Launchpad
# 12 - Notification Center

# Hot corner (top-left)
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0

# Hot corner (top-right)
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0

# Hot corner (bottom-left)
defaults write com.apple.dock wvous-bl-corner -int 2
defaults write com.apple.dock wvous-bl-modifier -int 0

# Hot corner (bottom-right)
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0

#-------------------------------------------------------------------------------
# Safari & WebKit
#-------------------------------------------------------------------------------

# Don't send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Show the full URL in the address bar (this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari's home page to "about:blank" for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening "safe" files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Pressing Backspace goes to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Show bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool true

# Enable Debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Enable Develop menu and the Web Inspector
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

# Disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Disable AutoFill
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Enable "Do Not Track"
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Automatically update extensions
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

#-------------------------------------------------------------------------------

for app in \
    "Dock" \
    "Finder" \
    "Safari" \
    "SystemUIServer" \
    ; do killall "${app}" &> /dev/null
done
