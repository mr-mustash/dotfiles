-- Spoons

-- Config reloading
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
    notification("Config Reloaded")
    hs.reload()
end)


-- WiFi
wifiWatcher = nil
homeSSID = "FBI Party Van"
workSSID = "NEWR"
lastSSID = hs.wifi.currentNetwork()

function ssidChangedCallback()
    newSSID = hs.wifi.currentNetwork()

    if newSSID == homeSSID and lastSSID ~= homeSSID then
        -- We just joined our home WiFi network
        homeWifiConnected()
    elseif newSSID == workSSID and lastSSID ~= workSSID then
        -- Connected to work Wifi
        workWifiConnected()
    elseif newSSID ~= homeSSID and lastSSID == homeSSID or newSSID ~= workSSID and lastSSID == workSSID then
        -- Connected to unknown WiFi networ
        unknownWifiNetwork()
    end

    lastSSID = newSSID
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()

function homeWifiConnected()
    hs.audiodevice.defaultOutputDevice():setVolume(50)
    restartProxy()
    notification("Welcome home!")
end

function workWifiConnected()
    hs.audiodevice.defaultOutputDevice():setVolume(0)
    restartProxy()
    notification("Welcome back to the office!")
end

function unknownWifiNetwork()
    hs.audiodevice.defaultOutputDevice():setVolume(0)
    restartProxy()
    notification("Unknown WiFi Network")
end

-- Proxy
function restartProxy()
    hs.execute("killall autossh ; autossh -M 8887 -f -D localhost:8888 -N -i ~/.ssh/proxy.pem ubuntu@34.220.210.10", true)
end

-- Generalized functions
function notification(notification)
    hs.notify.new({title="Hammerspoon", informativeText=notification}):send()
end
