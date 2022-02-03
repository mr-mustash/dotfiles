tell application "System Events"
	tell process "Macs Fan Control"
		set mfc to (menu bar item 1 of menu bar 2)
		ignoring application responses
			click mfc
		end ignoring
	end tell
end tell

do shell script "killall System\\ Events"
delay 0.1
tell application "System Events" to tell process "SystemUIServer"
	tell (first menu item whose title is "Automatic") of menu of mfc
		click
	end tell
end tell
