local stretchly = {}

local function stretchlyCall(name, eventType, app)
    if name == "Stretchly" and eventType == hs.application.watcher.activated then
        _log("Stretchly running")
        audioControl.muteInputs()
        audioControl.muteOutputs()

        display.setAllBrightness(10)
    end

    if name == "Stretchly" and eventType == hs.application.watcher.deactivated then
        _log("Stretchly closed")
        audioControl.unmuteInputs()
        audioControl.unmuteOutputs()

        display.setAllBrightness(90)
    end
end

function stretchly.init()
    stretchlyWatcher = hs.application.watcher.new(stretchlyCall)
    stretchlyWatcher:start()
    _log("Stretchly config loaded")
end
return stretchly
