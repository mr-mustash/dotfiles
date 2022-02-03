reload = {}

local function reloadConfig(paths)
    doReload = false
    for _, file in pairs(paths) do
        if file:sub(-4) == ".lua" then
            _log("Reloading: " .. file)
            doReload = true
        end
    end
    if doReload then
        notification("Config reloaded")
        hs.reload()
    end
end

function reload.init()
    if auto_reload == true then
        _log("Loaded reload function.")
        configFileWatcher =
            hs.pathwatcher.new(hs.configdir, reloadConfig):start()
    else
        _log("Auto reload disabled.")
    end
end

return reload
