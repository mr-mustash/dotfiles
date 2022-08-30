local zoom = {}
local zoomRunningTimer = nil

local function zoomTimerCallback()

    if
        hs.dialog.blockAlert(
        "Long Running Zoom",
        string.format("Zoom has been running for over an hour. Close it?"),
        "Close",
        "Keep Running",
        "NSCriticalAlertStyle"
        ) == "Close"
        then
            _log("Closing zoom.")
            hs.application.find('zoom.us'):kill()
            zoomRunningTimer = nil
        else
            _log("Resetting zoom timer for half an hour.")
            zoomRunningTimer = hs.timer.doAfter(1800, zoomTimerCallback)
        end
end

local function zoomCall(name, eventType, app)
    if name == "zoom.us" and (eventType == hs.application.watcher.launched or eventType == hs.application.watcher.activated) then
        _log("Zoom launched or focused.")

        -- This is duplicated from videoCall.lua as I don't always have my camera
        -- on during Zoom meetings, but I do want to pause Stertchly and notifications
        hs.shortcuts.run("Meeting Start")
        if hs.application.find("Stretchly") ~= nil then
            _log("Pausing stretchly")
            run.cmd("/Applications/Stretchly.app/Contents/MacOS/Stretchly", { "pause" })
        end

        -- Set up reminder to close Zoom
        if zoomRunningTimer ~= nil then
            _log(string.format("Zoom timer is already running with %s seconds left.", zoomRunningTimer:nextTrigger()))
        else
            _log("Starting zoom timer.")
            sleep(1)
            zoomRunningTimer = nil
            zoomRunningTimer = hs.timer.doAfter(3600, zoomTimerCallback)
        end
    end

    if name == "zoom.us" and eventType == hs.application.watcher.terminated then
        _log("Zoom closed.")

        -- This is duplicated from videoCall.lua as I don't always have my camera
        -- on during Zoom meetings, but I do want to pause Stertchly and notifications
        hs.shortcuts.run("Meeting End")
        if hs.application.find("Stretchly") ~= nil then
            _log("Resuming stretchly")
            run.cmd("/Applications/Stretchly.app/Contents/MacOS/Stretchly", { "resume" })
        end

        -- Remove reminder to close Zoom
        if zoomRunningTimer ~= nil then
            _log(string.format("Cancelling zoomRunningTimer with %s seconds left.", zoomRunningTimer:nextTrigger()))
            zoomRunningTimer:stop()
            zoomRunningTimer = nil
        end
    end
end

function zoom.init()
    local initStart = os.clock()
    stretchlyWatcher = hs.application.watcher.new(zoomCall)
    stretchlyWatcher:start()
    _log(debug.getinfo(1, "S").short_src:gsub(".*/", "") .. " loaded in " .. (os.clock() - initStart) .. " seconds.")
end
return zoom
