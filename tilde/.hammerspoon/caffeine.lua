local caffeine = {}

local function screenLocked()
    print "Screen Locked"
    audioControl.muteInputs()
end

local function screenUnlocked()
    print "Screen Unlocked"
    audioControl.unmuteInputs()
end

local function sleepCallback(event)
    if event == hs.caffeinate.watcher.screensDidLock or event == hs.caffeinate.watcher.screensDidSleep then
        screenLocked()
    elseif event == hs.caffeinate.watcher.screensDidUnlock then
        screenUnlocked()
    end
end

function caffeine.init()
    sleepWatcher = hs.caffeinate.watcher.new(sleepCallback)
    sleepWatcher:start()
end

return caffeine
