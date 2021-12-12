reload = {}

local function reloadConfig(paths)
    doReload = false
    for _,file in pairs(paths) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        notification("Config reloaded")
        hs.reload()
    end
end

function reload.init()
    configFileWatcher = hs.pathwatcher.new(hs.configdir, reloadConfig):start()
end

return reload
