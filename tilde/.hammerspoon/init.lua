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
homeSSID = "FBI Work Van"
workSSID = "Peloton"
lastSSID = hs.wifi.currentNetwork()

function ssidChangedCallback()
    newSSID = hs.wifi.currentNetwork()

    if newSSID == nil then
        return
    else
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
    end

    lastSSID = newSSID
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()

function homeWifiConnected()
    hs.audiodevice.defaultOutputDevice():setVolume(50)
    hs.execute("sudo /usr/sbin/networksetup -setdnsservers 'Wi-Fi' 10.13.36.1")
    notification("Welcome home!", home_logo)
    -- Leave at the end because it's blocking
    reconnectProxy()
end

function workWifiConnected()
    hs.audiodevice.defaultOutputDevice():setVolume(0)
    hs.execute("sudo /usr/sbin/networksetup -setdnsservers 'Wi-Fi' 1.1.1.1")
    notification("Welcome back to the office!", newrelic_logo)
    -- Leave at the end because it's blocking
    reconnectProxy()
end

function unknownWifiNetwork()
    hs.audiodevice.defaultOutputDevice():setVolume(0)
    hs.execute("sudo /usr/sbin/networksetup -setdnsservers 'Wi-Fi' 1.1.1.1")
    notification("Unknown WiFi Network")
    -- Leave at the end because it's blocking
    reconnectProxy()
end

function reconnectProxy()
    hs.execute("/usr/bin/pgrep autossh | /usr/bin/xargs kill ")
    sleep(1)
    hs.execute("/usr/bin/screen -dmS proxy /usr/local/bin/autossh -M 0 -N -v -i /Users/patrick.king/.ssh/id_ed25519_digitalocean -D localhost:18888 proxy")
    print("Proxy restarted")
end

-- Docked/Undocked
function dockChangedState(state)
    if state == "removed" then
        print("Undocked")
        hs.wifi.setPower(true)
        for _,screen in pairs(hs.screen.allScreens()) do
            screen:setBrightness(75)
        end
        -- Leave at the end because it's blocking
        reconnectProxy()
    end

    if state == "added" then
        print("Docked")
        for _,screen in pairs(hs.screen.allScreens()) do
            screen:setBrightness(100)
        end

        hs.execute("sudo networksetup -setdnsservers 'Akito Dock 10Gbps' 10.13.36.1")
        -- Leave these end since they're blocking
        disableWifiSlowly()
        reconnectProxy()

    end
end

function disableWifiSlowly()
    sleep(15)
    hs.wifi.setPower(false)
    print("Wifi disabled after being docked.")
end

-- USB Watcher
function usbkWatcherCallback(data)
    -- AKiTiO Pro Thunderbolt Dock
    if data.vendorName == "AKiTiO" then
        dockChangedState(data.eventType)
    end
end

usbWatcher = hs.usb.watcher.new(usbkWatcherCallback)
usbWatcher:start()

-- Pause Docker on Battery
local PreviousPowerSource = hs.battery.powerSource()

function powerStateChanged()
    CurrentPowerSource = hs.battery.powerSource()
    if CurrentPowerSource ~= PreviousPowerSource then
        if CurrentPowerSource == "Battery Power" then
            print("On battery power")
            hs.execute("tmutil stopbackup")
            hs.execute("pgrep -i Dropbox | xargs renice +19")
            stopDocker()
        end
        if CurrentPowerSource == "AC Power" then
            print("On AC power")
            hs.execute("pgrep -i Dropbox | xargs sudo renice +5")
            startDocker()
        end
        PreviousPowerSource = CurrentPowerSource
    end
end

function stopDocker()
    hs.execute("sudo /usr/bin/renice +19 -p $(/usr/bin/pgrep com.docker.hyperkit)")
    hs.execute("/usr/local/bin/docker ps -q > ~/.docker_stopped_containers")
    hs.execute("/usr/local/bin/docker stop $(/usr/local/bin/docker ps -q)")
end

function startDocker()
    hs.execute("cat ~/.docker_stopped_containers | xargs /usr/local/bin/docker start")
    hs.execute("sudo /usr/bin/renice +5 -p $(/usr/bin/pgrep com.docker.hyperkit)")
end

batteryWatcher = hs.battery.watcher.new(powerStateChanged)
batteryWatcher:start()

-- Generalized functions
function notification(notification, image)
    if (image == nil or image == '') then
        hs.notify.new({title="Hammerspoon", informativeText=notification, withdrawAfter=5}):send()
    else
        hs.notify.new({title="Hammerspoon", informativeText=notification, setIdImage=image, withdrawAfter=5}):send()
    end
end

function sleep(n)
    os.execute("sleep " .. tonumber(n))
end
