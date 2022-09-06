videocalls = {}

local function cameraInUse()
    hs.shortcuts.run("Meeting Start")

    if hs.application.find("Stretchly") ~= nil then
        _log("Pausing stretchly")
        run.cmd("/Applications/Stretchly.app/Contents/MacOS/Stretchly", { "pause" })
    end

    Elgato.cameraStart()
end

local function cameraStopped()
    hs.shortcuts.run("Meeting End")

    if hs.application.find("Stretchly") ~= nil then
        _log("Resuming stretchly")
        run.cmd("/Applications/Stretchly.app/Contents/MacOS/Stretchly", { "resume" })
    end

    Elgato.cameraEnd()
end

local function cameraPropertyCallback(camera, property)
    -- TODO: Think about logging which application has started to use the camera with something like:
    -- https://www.howtogeek.com/289352/how-to-tell-which-application-is-using-your-macs-webcam/
    _log("Camera " .. camera:name() .. "in use status changed.")

    -- Weirdly, "gone" is used as the property  if the camera's use changes: https://www.hammerspoon.org/docs/hs.camera.html#setPropertyWatcherCallback
    if property == "gone" then
        if camera:isInUse() then
            _log("Camera " .. camera:name() .. " is in use.")
            cameraInUse()
        else
            _log("Camera " .. camera:name() .. " is no longer in use.")
            cameraStopped()
        end
    end
end

local function cameraWatcherCallback(camera, status)
    _log("New camera detected: " .. camera:name())
    print(status)
    if status == "Added" then
        camera:setPropertyWatcherCallback(cameraPropertyCallback)
        camera:startPropertyWatcher()
    end
end

local function addCameraOnInit()
    for _, camera in ipairs(hs.camera.allCameras()) do
        _log("New camera detected: " .. camera:name())
        camera:setPropertyWatcherCallback(cameraPropertyCallback)
        camera:startPropertyWatcher()
    end
end

function videocalls.init()
    hs.camera.setWatcherCallback(cameraWatcherCallback)
    hs.camera.startWatcher()

    addCameraOnInit()
end

return videocalls
