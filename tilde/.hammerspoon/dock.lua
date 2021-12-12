local dock = {}

local function dockChangedState(state)
    if state == "removed" then
        print("Undocked")
        hs.wifi.setPower(true)
        hs.audiodevice.findInputByName('Built-in Microphone')
        reconnectProxy()
    end

    if state == "added" then
        print("Docked")
        hs.brightness.set(100)
        hs.execute("sudo networksetup -setdnsservers 'Akito Dock 10Gbps' 10.13.36.1")
        hs.audiodevice.findInputByName('Yeti X')
        -- Leave these end since they're blocking
        disableWifiSlowly()
        reconnectProxy()

    end
end

-- USB Watcher
local function usbkWatcherCallback(data)
    -- AKiTiO Pro Thunderbolt Dock
    if data.vendorName == "AKiTiO" then
        dockChangedState(data.eventType)
    end
end

function dock.init()
    usbWatcher = hs.usb.watcher.new(usbkWatcherCallback)
    usbWatcher:start()
end

return dock
