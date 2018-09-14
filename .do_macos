#!/usr/bin/env bash

if [ -z "$bootstrap" ]; then
    echo "This file is not intended to be called directly."
    exit 1
fi

# Quit System Preferences window if present to prevent anny accidental settings chance
osascript -e 'tell application "System Preferences" to quit'

#-------------------------------------------------------------------------------
# Low level system settings
#-------------------------------------------------------------------------------

task_start "macOS: Disable the boot sound effect"
# Apparently this does not work on High Sierra
sudo nvram SystemAudioVolume=" "
# sudo nvram -d SystemAudioVolume
task_stop

task_start "macOS: Restart automatically if the computer freezes"
sudo systemsetup -setrestartfreeze on
task_stop

#-------------------------------------------------------------------------------
# Visual appearance & general settings
#-------------------------------------------------------------------------------

task_start "macOS: Reduce transparency"
defaults write com.apple.universalaccess reduceTransparency -bool true
task_stop

task_start "macOS: Enable HiDPI resolutions in Display Preference Pane"
sudo defaults write /Library/Preferences/com.apple.windowserver.plist DisplayResolutionEnabled -bool true
# sudo defaults delete /Library/Preferences/com.apple.windowserver.plist DisplayResolutionEnabled
task_stop

task_start "macOS: Enable subpixel font rendering on non-Apple LCDs"
# Reference link: https://github.com/kevinSuttle/macOS-Defaults/issues/17
defaults write NSGlobalDomain AppleFontSmoothing -int 2
task_stop

task_start "macOS: Disable window opening and closing animation"
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
task_stop

task_start "macOS: Set highlight color to default blue"
# Reference link: https://apple.stackexchange.com/a/188170/135508
# Each decimal value is a RGB (from 0 to 255) divided by 255
# defaults write NSGlobalDomain AppleHighlightColor -string "0.701960784313725 0.847058823529412 0.992156862745098"
defaults delete -g AppleHighlightColor
task_stop

task_start "macOS: Set sidebar icon size"
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2
task_stop

task_start "macOS: Set scroll bars behaviour"
defaults write NSGlobalDomain AppleShowScrollBars -string "Always" # "Automatic" "WhenScrolling" "Always"
task_stop

task_start "macOS: Disable smooth scrolling"
defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false
task_stop

task_start "macOS: Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
task_stop

task_start "macOS: Expand print panel by default"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
task_stop

task_start "macOS: Disable file quarantining"
defaults write com.apple.LaunchServices LSQuarantine -bool false
# defaults delete com.apple.LaunchServices LSQuarantine
task_stop

# task_start "macOS: Remove duplicate items from Open With… menu"
# As a negative side effect, bunch of app icons may be temporarily gone and show a generic one
# /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
# task_stop

task_start "macOS: Disable Automatic Termination"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true
# defaults delete NSDisableAutomaticTermination
task_stop

task_start "macOS: Disable Crash Reporter"
defaults write com.apple.CrashReporter DialogType -string "none"
# defaults write com.apple.CrashReporter DialogType crashreport
task_stop

task_start "macOS: Empty ~/Library/Logs/*"
# Empty the content of ~/Library/Logs directory but not the directory itself
# It's safe to remove the content of this directory since it contains only logs
# After some time, it may consume a significant amount of disk space
sudo rm -rf ~/Library/Logs/*
task_stop

task_start "macOS: Show IP address, hostname and OS version when clicking the clock in the login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
# sudo defaults delete /Library/Preferences/com.apple.loginwindow AdminHostInfo
task_stop

task_start "macOS: Set the timezone"
sudo systemsetup -settimezone "Australia/Brisbane" > /dev/null
task_stop

task_start "macOS: Show input menu in login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true
task_stop

task_start "macOS: Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
task_stop

task_start "macOS: Adjust screenshot settings"
mkdir -p $HOME/Documents/Screenshots
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture location "$HOME/Documents/Screenshots"
defaults write com.apple.screencapture disable-shadow -bool true
task_stop

#-------------------------------------------------------------------------------
# Wallpaper
#-------------------------------------------------------------------------------

task_start "macOS: Set a solid black colour as background wallpaper on every display"
cp ./solid_black_wallpaper.png $HOME/Pictures/solid_black_wallpaper.png
osascript -e 'tell application "System Events" to tell every desktop to set picture to "~/Pictures/solid_black_wallpaper.png"'
task_stop

#-------------------------------------------------------------------------------
# Keyboard
#-------------------------------------------------------------------------------

task_start "macOS: Set keyboard repeat speed"
# Default GUI values for KeyRepeat are: 120, 90, 60, 30, 12, 6, 2 (lower value, faster speed)
# Default GUI values for InitialKeyRepeat are: 120, 94, 68, 35, 25, 15 (lower value, faster speed)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
task_stop

task_start "macOS: Disable automatic spelling correction"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
task_stop

task_start "macOS: Disable automatic capitalization"
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
task_stop

task_start "macOS: Disable smart dashes, period substitution and smart quotes"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
task_stop

task_start "macOS: Enable full keyboard access for all controls"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
task_stop

task_start "macOS: Disable press-and-hold for accents"
defaults write -g ApplePressAndHoldEnabled -bool false
task_stop

#-------------------------------------------------------------------------------
# Mouse & Trackpad
#-------------------------------------------------------------------------------

task_start "macOS: Enable tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
task_stop

#-------------------------------------------------------------------------------
# Regional settings
#-------------------------------------------------------------------------------

task_start "macOS: Set language and text format"
defaults write NSGlobalDomain AppleLanguages -array "en" "pl"
defaults write NSGlobalDomain AppleLocale -string "en_AU@currency=AUD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true
task_stop

#-------------------------------------------------------------------------------
# Finder
#-------------------------------------------------------------------------------

task_start "macOS Finder: Disable all animations"
defaults write com.apple.finder DisableAllAnimations -bool true
task_stop

task_start "macOS Finder: Set default location for newly opened windows"
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
task_stop

task_start "macOS Finder: Toggle visibility of icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
task_stop

task_start "macOS Finder: Show hidden files, all extensions, status bar and path bar"
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
task_stop

task_start "macOS Finder: Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
task_stop

task_start "macOS Finder: Search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
task_stop

task_start "macOS Finder: Don't warn when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
task_stop

task_start "macOS Finder: Keep folders on top when sorting by name"
defaults write com.apple.finder _FXSortFoldersFirst -bool true
task_stop

task_start "macOS Finder: Avoid creating .DS_Store files on network or USB volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
task_stop

task_start "macOS Finder: Disable disk image verification"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
task_stop

task_start "macOS Finder: Automatically open a new Finder window when a volume is mounted"
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
task_stop

task_start "macOS Finder: Use list view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv" # Nlsv - list view, Flwv - cover flow view, clmv - column view, icnv - icon view 
task_stop

task_start "macOS Finder: Warn before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool true
task_stop

task_start "macOS Finder: Unhide specific directories"
sudo chflags nohidden /Volumes
sudo chflags nohidden ~/Library
task_stop

task_start "macOS Finder: Expand specific File Info panes"
defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    OpenWith -bool true \
    Privileges -bool true
task_stop

#-------------------------------------------------------------------------------
# Menu bar
#-------------------------------------------------------------------------------

# On High Sierra killing Finder is not enough to see this change immediately.
# Every app should be restarted for menu bar to respect the followin setting.
task_start "macOS: Make menu bar always visible"
defaults write NSGlobalDomain _HIHideMenuBar -bool false
task_stop

#-------------------------------------------------------------------------------
# Dock
#-------------------------------------------------------------------------------

# Below command restores Dock to the default state.
# I don't want to use it but it's good to keep it as a reference.
# task_start "macOS Dock: Restore it to a default state"
# defaults delete com.apple.dock
# task_stop

task_start "macOS Dock: Enable highlight hover effect for the grid view of a stack"
defaults write com.apple.dock mouse-over-hilite-stack -bool true
task_stop

task_start "macOS Dock: Set the icon size"
defaults write com.apple.dock tilesize -int 48
task_stop

task_start "macOS Dock: Set minimize window effect"
defaults write com.apple.dock mineffect -string "scale" # (other option is "genie")
task_stop

task_start "macOS Dock: Minimize windows into their application's icon"
defaults write com.apple.dock minimize-to-application -bool true
task_stop

task_start "macOS Dock: Enable spring loading for all Dock items"
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true
task_stop

task_start "macOS Dock: Show indicators for open applications"
defaults write com.apple.dock show-process-indicators -bool true
task_stop

task_start "macOS Dock: Don't animate (bounce) opening applications"
defaults write com.apple.dock launchanim -bool false
task_stop

task_start "macOS Dock: Disable auto-hide"
defaults write com.apple.dock autohide -bool false
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
task_stop

#-------------------------------------------------------------------------------
# Hot corners
#-------------------------------------------------------------------------------

task_start "macOS: Set hot corners"
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
task_stop

#-------------------------------------------------------------------------------
# Safari & WebKit
#-------------------------------------------------------------------------------

task_start "macOS Safari: Don't send search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
task_stop

task_start "macOS Safari: Press Tab to highlight each item on a web page"
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true
task_stop

task_start "macOS Safari: Show the full URL in the address bar (this still hides the scheme)"
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
task_stop

task_start "macOS Safari: Set Safari's home page to about:blank for faster loading"
defaults write com.apple.Safari HomePage -string "about:blank"
task_stop

task_start "macOS Safari: Prevent Safari from opening safe files automatically after downloading"
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
task_stop

task_start "macOS Safari: Pressing Backspace goes to the previous page in history"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true
task_stop

task_start "macOS Safari: Show bookmarks bar"
defaults write com.apple.Safari ShowFavoritesBar -bool true
task_stop

task_start "macOS Safari: Enable Debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
task_stop

task_start "macOS Safari: Enable Develop menu and the Web Inspector"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
task_stop

task_start "macOS Safari: Add a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
task_stop

task_start "macOS Safari: Enable continuous spellchecking"
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
task_stop

task_start "macOS Safari: Disable auto-correct"
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false
task_stop

task_start "macOS Safari: Disable AutoFill"
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false
task_stop

task_start "macOS Safari: Warn about fraudulent websites"
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true
task_stop

task_start "macOS Safari: Enable Do Not Track"
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true
task_stop

task_start "macOS Safari: Automatically update extensions"
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true
task_stop

#-------------------------------------------------------------------------------
# Mail
#-------------------------------------------------------------------------------

task_start "macOS Mail: Disable send and reply animations"
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true
task_stop

task_start "macOS Mail: Copy e-mail addresses without the name"
# Copy e-mail addresses as "john.doe@example.com" instead of "John Doe <john.doe@example.com>"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
task_stop

task_start "macOS Mail: Don't display e-mails in threaded mode"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
task_stop

task_start "macOS Mail: Sort e-mails by date (oldest on top)"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"
task_stop

#-------------------------------------------------------------------------------

for app in \
    "Dock" \
    "Finder" \
    "Mail" \
    "Safari" \
    "SystemUIServer" \
    ; do killall "${app}" &> /dev/null
done
