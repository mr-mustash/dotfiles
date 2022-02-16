local caffeine = {}

local function screenLocked()
    _log("Screen Locked")
    audioControl.muteInputs()
end

local function screenUnlocked()
    _log("Screen Unlocked")
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
    local initStart = os.clock()
    sleepWatcher = hs.caffeinate.watcher.new(sleepCallback)
    sleepWatcher:start()

    _log(debug.getinfo(1, "S").short_src:gsub(".*/", "") .. " loaded in " .. (os.clock() - initStart) .. " seconds.")
end

return caffeine
