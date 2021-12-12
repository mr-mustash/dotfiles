zoomconfig = {}

local function zoomStart()
    print("Staring Zoom meeting")
    --hs.application.launchOrFocus("OBS")
    --sleep(5)
    --local sceneJSON=[[{ "scene-name": "Webcam Only" }]]
    --local command=("/usr/local/bin/obs-cli SetCurrentScene=" .. sceneJSON .. " >> ~/Desktop/obsout.txt 2>&1")
    --hs.execute(command, with_user_env)
    --hs.execute("/usr/local/bin/obs-cli StartVirtualCam", with_user_env)
    hs.execute("/usr/local/bin/do-not-disturb on")
end

local function zoomEnd()
    print("Ending Zoom meeting")
    --hs.execute("/usr/local/bin/obs-cli StopVirtualCam", with_user_env)
    hs.execute("/usr/local/bin/do-not-disturb off")
    --sleep(1)
    --local appOBS = hs.application.find("OBS")
    --if(appOBS ~= nil) then
    --    appOBS.kill(appOBS)
    --end
end

local function updateZoomStatus(event)
    hs.printf("updateZoomStatus(%s)", event)
    if (event == "from-running-to-meeting") then
        zoomStart()
    elseif (event == "from-meeting-to-running") or (event == "from-running-to-closed") then
        zoomEnd()
    end
end

function zoomconfig.init()
    spoon.Zoom:setStatusCallback(updateZoomStatus)
    spoon.Zoom:start()
end

return zoomconfig
