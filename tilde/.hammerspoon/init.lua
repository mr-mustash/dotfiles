-- Init
hs.logger.defaultLogLevel="info"

-- Path Management
local basePath = os.getenv("HOME") .. "/.hammerspoon/"

-- Global Values
hyper = {"cmd","alt","ctrl"}
shift_hyper = {"cmd","alt","ctrl","shift"}

newrelic_logo = hs.image.imageFromPath(hs.configdir .. "/assets/newrelic.png")
home_logo = hs.image.imageFromPath(hs.configdir .. "/assets/king.png")

-- Spoons

--------------------------------------------
-- Config reloading

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
        notification("Config Reloaded")
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

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
    notification("Welcome home!", home_logo)
end

function workWifiConnected()
    hs.audiodevice.defaultOutputDevice():setVolume(0)
    restartProxy()
    notification("Welcome back to the office!", newrelic_logo)
end

function unknownWifiNetwork()
    hs.audiodevice.defaultOutputDevice():setVolume(0)
    restartProxy()
    notification("Unknown WiFi Network")
end

-- Proxy
function restartProxy()
    hs.execute("killall autossh ; autossh -M 18887 -f -D localhost:18888 -N ubuntu@34.220.194.173", true)
end

function restartProxyCompressed()
    hs.execute("killall autossh ; autossh -M 18887 -f -D localhost:18888 -N -C ubuntu@34.220.194.173", true)
end

-- Any Complete
local anycomplete = require "anycomplete/anycomplete"
anycomplete.registerDefaultBindings()

-- Generalized functions
function notification(notification, image)
    if (image == nil or image == '') then
        hs.notify.new({title="Hammerspoon", informativeText=notification, withdrawAfter=5}):send()
    else
        hs.notify.new({title="Hammerspoon", informativeText=notification, setIdImage=image, withdrawAfter=5}):send()
    end
end
