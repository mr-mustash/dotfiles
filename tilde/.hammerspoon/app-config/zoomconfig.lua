zoomconfig = {}

local function zoomStart()
    _log("Staring Zoom meeting")
    -- hs.application.launchOrFocus("OBS")
    -- sleep(5)
    -- local sceneJSON=[[{ "scene-name": "Webcam Only" }]]
    -- local command=("/usr/local/bin/obs-cli SetCurrentScene=" .. sceneJSON .. " >> ~/Desktop/obsout.txt 2>&1")
    -- hs.execute(command, with_user_env)
    -- hs.execute("/usr/local/bin/obs-cli StartVirtualCam", with_user_env)
    elgato.zoomStart()
    hs.execute("/usr/local/bin/calm-notifications on")
    -- hs.spotify.pause()
    if hs.application.find("Stretchly") ~= nil then
        _log("Pausing stretchly")
        hs.execute(
            "/Applications/Stretchly.app/Contents/MacOS/Stretchly pause 2>/dev/null")
    end
end

local function zoomEnd()
    _log("Ending Zoom meeting")
    -- hs.execute("/usr/local/bin/obs-cli StopVirtualCam", with_user_env)
    hs.execute("/usr/local/bin/calm-notifications off")
    if hs.application.find("Stretchly") ~= nil then
        _log("Resuming stretchly")
        hs.execute(
            "/Applications/Stretchly.app/Contents/MacOS/Stretchly resume 2>/dev/null")
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
    elseif (event == "from-meeting-to-running") or
        (event == "from-running-to-closed") then
        zoomEnd()
    end
end

function zoomconfig.init()
    spoon.Zoom:setStatusCallback(updateZoomStatus)
    spoon.Zoom:start()
    _log("Zoom config loaded")
end

return zoomconfig
