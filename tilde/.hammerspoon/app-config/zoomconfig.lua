zoomconfig = {}

local function zoomStart()
    _log("Staring Zoom meeting")
    hs.shortcuts.run("Meeting Start")
    -- hs.spotify.pause()
    if hs.application.find("Stretchly") ~= nil then
        _log("Pausing stretchly")
        run.cmd("/Applications/Stretchly.app/Contents/MacOS/Stretchly", { "pause" })
    end
    elgato.zoomStart()
end

local function zoomEnd()
    _log("Ending Zoom meeting")
    hs.shortcuts.run("Meeting End")
    if hs.application.find("Stretchly") ~= nil then
        _log("Resuming stretchly")
        run.cmd("/Applications/Stretchly.app/Contents/MacOS/Stretchly", { "resume" })
    end
    elgato.zoomEnd()
    -- sleep(1)
    -- local appOBS = hs.application.find("OBS")
    -- if(appOBS ~= nil) then
    --    appOBS.kill(appOBS)
    -- end
end

local function updateZoomStatus(event)
    _log("Zoom status: " .. event)
    if event == "from-running-to-meeting" then
        zoomStart()
    elseif (event == "from-meeting-to-running") or (event == "from-running-to-closed") then
        zoomEnd()
    end
end

function zoomconfig.init()
    local initStart = os.clock()
    spoon.Zoom:setStatusCallback(updateZoomStatus)
    spoon.Zoom:start()
    _log(debug.getinfo(1, "S").short_src:gsub(".*/", "") .. " loaded in " .. (os.clock() - initStart) .. " seconds.")
end

return zoomconfig
