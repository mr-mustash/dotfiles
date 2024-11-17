local movies = {}

local previousBrightness = hs.brightness.get()

-- List of applications to watch
local watchedApps = {
    "Movist Pro",
    "TV"  -- Add other app names here as needed
}

local function isWatchedApp(name)
    for _, appName in ipairs(watchedApps) do
        if name == appName then
            return true
        end
    end
    return false
end

local function moviestCall(name, eventType, _)
    if isWatchedApp(name) then  -- Check if the app is in the watched list
        if eventType == hs.application.watcher.activated then
            previousBrightness = hs.brightness.get()
            _log(string.format("%s activated. Previous brightness was %s.", name, previousBrightness))

            hs.shortcuts.run("Enable Vivid")
            hs.brightness.set(100)

        elseif eventType == hs.application.watcher.deactivated then
            _log(string.format("%s deactivated. Restoring brightness to %s.", name, previousBrightness))

            hs.shortcuts.run("Disable Vivid")
            hs.brightness.set(previousBrightness)
        end
    end
end

function movies.init()
    local initStart = os.clock()
    moviestWatcher = hs.application.watcher.new(moviestCall)
    moviestWatcher:start()
    _log(string.format("%s loaded in %.4f seconds.", debug.getinfo(1, "S").short_src:match("([^/]+)$"), os.clock() - initStart))
end

return movies
