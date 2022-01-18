networking = {}

wifiWatcher = nil
homeSSID = "FBI Work Van"
workSSID = "Peloton"
lastSSID = hs.wifi.currentNetwork()

local function homeWifiConnected()
    hs.audiodevice.defaultOutputDevice():setVolume(50)
    --hs.execute("sudo /usr/sbin/networksetup -setdnsservers 'Wi-Fi' 10.13.36.1")
    notification("Welcome home!", home_logo)
    print("Connected to home WiFi")
    -- Leave at the end because it's blocking
    reconnectProxy()
end

local function workWifiConnected()
    hs.audiodevice.defaultOutputDevice():setVolume(0)
    --hs.execute("sudo /usr/sbin/networksetup -setdnsservers 'Wi-Fi' 1.1.1.1")
    notification("Welcome back to the office!")
    print("Connected to work WiFi")
    -- Leave at the end because it's blocking
    reconnectProxy()
end

local function unknownWifiNetwork()
    hs.audiodevice.defaultOutputDevice():setVolume(0)
    --hs.execute("sudo /usr/sbin/networksetup -setdnsservers 'Wi-Fi' 1.1.1.1")
    notification("Unknown WiFi Network")
    print("Connected to unknown WiFi")
    -- Leave at the end because it's blocking
    reconnectProxy()
end

function disableWifiSlowly()
    sleep(15)
    hs.wifi.setPower(false)
    print("Wifi disabled after being docked.")
end

function reconnectProxy()
    sleep(10)
    hs.execute("/usr/bin/pgrep autossh | /usr/bin/xargs kill ")
    sleep(1)
    hs.execute("/usr/bin/screen -dmS proxy /usr/local/bin/autossh -M 0 -N -D localhost:18888 proxy")
    print("Proxy restarted")
end

local function ssidChangedCallback()
    newSSID = hs.wifi.currentNetwork()

    if newSSID ~= nil then
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
    else
        return
    end

    lastSSID = newSSID
end

function networking.init()
    wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
    wifiWatcher:start()
end

return networking
