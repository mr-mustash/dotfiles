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
hs.hotkey.bind(hyper, "R", function()
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

-- Use the caffenaite watcher to turn the WiFi watcher on and off.
cwatcher = hs.caffeinate.watcher.new(function(state)
   if state == hs.caffeinate.watcher.systemDidWake then
      wifiWatcher:start()
   elseif state == hs.caffeinate.watcher.systemWillSleep then
       wifiWatcher:stop()
   end
end)
cwatcher:start()


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
    hs.execute("killall autossh ; autossh -M 8887 -f -D localhost:8888 -N -i ~/.ssh/proxy.pem ubuntu@34.220.210.10", true)
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
