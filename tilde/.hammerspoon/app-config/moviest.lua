local moviest = {}

local function moviestCall(name, eventType, _)
    if name == "Movist Pro" and eventType == hs.application.watcher.activated then
        _log("Moviest running")
        Vivid.toggle()
    end

    if name == "Movist Pro" and eventType == hs.application.watcher.deactivated then
        _log("Moviest closed")
        Vivid.toggle()
    end
end

function moviest.init()
    local initStart = os.clock()
    moviestWatcher = hs.application.watcher.new(moviestCall)
    moviestWatcher:start()
    _log(debug.getinfo(1, "S").short_src:gsub(".*/", "") .. " loaded in " .. (os.clock() - initStart) .. " seconds.")
end
return moviest
