#!/bin/bash -xe

softwareupdate --download --verbose --install --all

# Ask for the administrator password upfront
if ! sudo -v; then
	echo "ERROR: Need to provide sudo password."
	exit 1
fi

# Keep-alive: update existing `sudo` time stamp until `defaults.sh` has finished
while true; do
	sudo -n true
	sleep 120
	kill -0 "$$" || exit
done 2>/dev/null &

# Agree to the Xcode license
if /usr/bin/xcode-select -p; then
	echo "Xcode Command Line Tools already installed"
else
	echo "Installing Xcode Command Line Tools"
	sudo /usr/bin/xcode-select --install
fi

# Sync time
sudo sntp -sS -t 10 pool.ntp.org

# Close System Settings to prevent it from overriding settings we’re about to
# change
osascript -e 'tell application "System Settings" to quit'

# Dock  =================================================================== {{{

defaults write com.apple.dock autohide -bool true             # autohide dock
defaults write com.apple.dock autohide-delay -int 0           # immediately autohide dock
defaults write com.apple.dock autohide-time-modifier -float 0 # make dock appear/hide instantly
defaults write com.apple.dock show-recents -bool false        # Do not show recent apps on dock

# Bottom left screen corner → Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# ========================================================================= }}}
# Finder  ================================================================= {{{

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Set Desktop as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

defaults write com.apple.finder AppleShowAllFiles -bool true               # Show hidden files by default
defaults write com.apple.finder ShowPathbar -bool true                     # Show path bar in finder
defaults write com.apple.finder ShowStatusBar -bool true                   # Show status bar in finder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true         # Display full POSIX path as Finder window title
defaults write com.apple.finder _FXSortFoldersFirst -bool true             # Keep folders on top when sorting by name
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"        # When performing a search, search the current folder by default
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false # Disable the warning when changing a file extension
defaults write com.apple.finder QLEnableTextSelection -bool true           # Allow text selection in Quick Look
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"        # Use list view in all Finder windows by defaul

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true # Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true     # Avoid creating .DS_Store files on USB volumes

defaults write NSGlobalDomain AppleShowAllExtensions -bool true # Show all filename extensions

chflags nohidden ~/Library     # Show the ~/Library folder
sudo chflags nohidden /Volumes # Show the /Volumes folder

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Set grid spacing for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 50" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 50" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 50" ~/Library/Preferences/com.apple.finder.plist

# Expand all "Finder Info" panes
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

# ========================================================================= }}}
# Save Panel  ============================================================= {{{

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false # Save to disk (not to iCloud) by default

# ========================================================================= }}}
# Print Settings  ========================================================= {{{

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable printer sharing
cupsctl --no-share-printers
cupsctl --no-remote-any
cupsctl --no-remote-admin
# ========================================================================= }}}
# User Experience ========================================================= {{{

defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false # Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false  # Disable smart dashes as they’re annoying when typing code

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 25

defaults write -g CGFontRenderingFontSmoothingDisabled -bool FALSE                                  # Re-enable subpixel antialiasing
defaults write NSGlobalDomain AppleFontSmoothing -int 1                                             # Enable subpixel font rendering on non-Apple LCDs
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true # Enable HiDPI display modes (requires restart)

defaults write com.apple.dock mru-spaces -bool false               # Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock expose-animation-duration -float 0.1 # Speed up Mission Control animations

# ========================================================================= }}}
# Safari ================================================================== {{{

# defaults write com.apple.Safari HomePage -string "about:blank"           # Set Safari’s home page to `about:blank` for faster loading
# defaults write com.apple.Safari ShowFavoritesBar -bool false             # Hide Safari’s bookmarks bar by default
# defaults write com.apple.Safari ShowSidebarInTopSites -bool false        # Hide Safari’s sidebar in Top Sites
# defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true # Show the full URL in the address bar

# Don’t send search queries to Apple
# defaults write com.apple.Safari UniversalSearchEnabled -bool false
# defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# ========================================================================= }}}

# Firefox ================================================================= {{{

sudo defaults write /Library/Preferences/org.mozilla.firefox EnterprisePoliciesEnabled -bool TRUE
sudo defaults write /Library/Preferences/org.mozilla.firefox DisableTelemetry -bool TRUE

# ========================================================================= }}}
# Activity Monitor ======================================================== {{{

defaults write com.apple.ActivityMonitor OpenMainWindow -bool true # Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor IconType -int 5           # Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor ShowCategory -int 0       # Show all processes in Activity Monitor

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# ========================================================================= }}}
# Text Edit =============================================================== {{{

defaults write com.apple.TextEdit RichText -int 0 # Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit "TabWidth" '4'  # Set tab width to 4 instead of the default 8
# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# ========================================================================= }}}
# Time Machine ============================================================ {{{

exclusions=("$HOME/.local"
	"$HOME/Downloads"
	"$HOME/Dropbox"
	"$HOME/Library/Caches"
	"$HOME/Library/Logs"
	"$HOME/Library/Application\ Support/MacUpdater/OldAppBackups"
	"$HOME/Library/Application\ Support/MacUpdater/NewDownloadBackups"
	"$HOME/Library/Application\ Support/Steam")

for directory in "${exclusions[@]}"; do
	if [ -d "${directory}" ]; then
		sudo tmutil addexclusion "${directory}"
	else
		echo "Directory ${directory} does not exist."
	fi
done

# ========================================================================= }}}
# Misc ==================================================================== {{{

defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1 # Check for software updates daily, not just once per week
sudo pmset -a hibernatemode 0                                    # Disable hibernation (speeds up entering sleep mode)

# Add message to login screen.
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "This computer is attached to an iCloud account and permanently locked. Please return by calling 503-805-4667. Reward included, and no questions asked."

# ========================================================================= }}}

# Privacy & Security ====================================================== {{{

# Privacy & Security#Misc ================================================= {{{
dsenableroot -d # Disable root user

sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -stop # Deactivate remote management service
sudo systemsetup -setremoteappleevents off                                                                     # Disable remote apple events

defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false # Disable internet based spellcheck
# ========================================================================= }}}

# Privacy#Siri ============================================================ {{{
defaults write com.apple.assistant.support 'Siri Data Sharing Opt-In Status' -int 2
defaults write com.apple.assistant.support 'Assistant Enabled' -bool false
defaults write com.apple.assistant.backedup 'Use device speaker for TTS' -int 3
launchctl disable "user/$UID/com.apple.assistantd"
launchctl disable "gui/$UID/com.apple.assistantd"
sudo launchctl disable 'system/com.apple.assistantd'
launchctl disable "user/$UID/com.apple.Siri.agent"
launchctl disable "gui/$UID/com.apple.Siri.agent"
sudo launchctl disable 'system/com.apple.Siri.agent'
defaults write com.apple.SetupAssistant 'DidSeeSiriSetup' -bool True
defaults write com.apple.systemuiserver 'NSStatusItem Visible Siri' 0
defaults write com.apple.Siri 'StatusMenuVisible' -bool false
defaults write com.apple.Siri 'UserHasDeclinedEnable' -bool true

# ========================================================================= }}}
# Privacy#Advertising ===================================================== {{{

# Disable Advertising Identifier
defaults write com.apple.AdLib allowIdentifierForAdvertising -bool false
defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false
defaults write com.apple.AdLib forceLimitAdTracking -bool true

# ========================================================================= }}}
# Security#Firewall ======================================================= {{{

sudo defaults write /Library/Preferences/com.apple.alf allowsignedenabled -bool false
sudo defaults write /Library/Preferences/com.apple.alf allowdownloadsignedenabled -bool false
sudo defaults write /Library/Preferences/com.apple.alf globalstate -bool true
sudo defaults write /Library/Preferences/com.apple.alf loggingenabled -bool true
sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -bool true
defaults write com.apple.security.firewall EnableFirewall -bool true
defaults write com.apple.security.firewall EnableStealthMode -bool true
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned off
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp off

sudo pkill -HUP socketfilterfw

# ========================================================================= }}}
# Security#Screensaver ==================================================== {{{

sudo defaults write /Library/Preferences/com.apple.screensaver askForPassword -bool true
sudo defaults write /Library/Preferences/com.apple.screensaver 'askForPasswordDelay' -int 0

# ========================================================================= }}}
# Security#Guest Account ================================================== {{{

sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool NO
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool NO
sudo defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool NO

# ========================================================================= }}}
# Security#Remote Access ================================================== {{{

echo 'yes' | sudo systemsetup -setremotelogin off
sudo launchctl disable 'system/com.apple.tftpd'
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true
sudo launchctl disable system/com.apple.telnetd

# ========================================================================= }}}
# Security#Google Update ================================================== {{{

googleUpdateFile=~/Library/Google/GoogleSoftwareUpdate/GoogleSoftwareUpdate.bundle/Contents/Resources/ksinstall
if [ -f "$googleUpdateFile" ]; then
	$googleUpdateFile --nuke
	echo Uninstalled google update
else
	echo Google update file does not exist
fi

# ========================================================================= }}}
# Security#Quarantine Log ================================================= {{{
file_to_lock=~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV2
if [ -f "$file_to_lock" ]; then
	sudo chflags schg "$file_to_lock"
	echo "Made file immutable at \"$file_to_lock\""
else
	echo "No action is needed, file does not exist at \"$file_to_lock\""
fi

# ========================================================================= }}}

killall Dock
killall Finder
