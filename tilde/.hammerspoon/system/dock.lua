local dock = {}

local function docked()
    _log("Docked")
    is_docked = true

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
end

local function undocked()
    _log("Undocked")
    is_docked = false
    hs.wifi.setPower(true)

    run.brewcmd("blueutil", {"--disconnect", secrets.dock.mouseID})

    ethernetMenubar:removeFromMenuBar()
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
    usbWatcher = hs.usb.watcher.new(usbkWatcherCallback)
    usbWatcher:start()

    ethernetMenubar = hs.menubar.new()

    if dock.isDocked() == true then
        dockChangedState("added")
        is_docked = true
        _log("Dock present on reload.")
    else
        dockChangedState("removed")
        is_docked = false
        _log("Dock not found on reload.")
    end

    _log(debug.getinfo(1, "S").short_src:gsub(".*/", "") .. " loaded in " .. (os.clock() - initStart) .. " seconds.")
end

return dock
