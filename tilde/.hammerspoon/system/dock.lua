local dock = {}
dock.Is_docked = nil

local function docked()
    _log(string.format("Docked is: %s", dock.Is_docked))
    if dock.Is_docked == true then
        _log("Docked, but dock.Is_docked already true. Not running thrugh setup again.")
        return
    end

    dock.Is_docked = true
    _log("Docked, Setting up docked mode.")

    networking.disableWifiSlowly()
    networking.networkReconnect(secrets.networking.homeDNS)

    run.brewcmd("blueutil", {"--connect", secrets.dock.mouseID})

    local lan = networking.checkForLAN()
    ethernetMenubar:returnToMenuBar()
    if lan == "lan" then
        ethernetMenubar:setTitle(hs.styledtext.new("", menubarLargeStyle))
    elseif lan == "none" then
        ethernetMenubar:setTitle(hs.styledtext.new("", menubarLargeStyle))
    end

    for _, app in ipairs(secrets.dock.dockedApps) do
        run.startApp(app, true)
    end
end

local function undocked()
    _log("Undocked")
    dock.Is_docked = false
    hs.wifi.setPower(true)

    run.brewcmd("blueutil", {"--disconnect", secrets.dock.mouseID})

    ethernetMenubar:removeFromMenuBar()

    for _, app in ipairs(secrets.dock.dockedApps) do
        run.closeApp(app)
    end
end

local function dockChangedState(state)
    if state == "removed" then
        undocked()
    elseif state == "added" then
        docked()
    else
        _log("Unknown dock state: " .. state)
    end
end

-- USB Watcher
local function usbkWatcherCallback(data)
    -- AKiTiO Pro Thunderbolt Dock
    if data.vendorName == secrets.dock.dock then
        dockChangedState(data.eventType)
    end
end

function dock.isDocked()
    local usbDevices = hs.usb.attachedDevices()
    for _, device in pairs(usbDevices) do
        if device.vendorName == secrets.dock.dock then
            return true
        end
    end
    return false
end

function dock.init()
    local initStart = os.clock()
    ethernetMenubar = hs.menubar.new()

    -- Check for dock on reload first
    if dock.isDocked() == true then
        dockChangedState("added")
        dock.Is_docked = true
        _log("Dock present on reload.")
    else
        dockChangedState("removed")
        dock.Is_docked = false
        _log("Dock not found on reload.")
    end

    -- Set up watcher for future dock connects/disconnects
    usbWatcher = hs.usb.watcher.new(usbkWatcherCallback)
    usbWatcher:start()

    _log(debug.getinfo(1, "S").short_src:gsub(".*/", "") .. " loaded in " .. (os.clock() - initStart) .. " seconds.")
end

return dock
