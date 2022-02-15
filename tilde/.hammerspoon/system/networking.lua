networking = {}

wifiWatcher = nil
homeSSID = secrets.networking.homeSSID
workSSID = secrets.networking.workSSID
lastSSID = hs.wifi.currentNetwork()

proxyPid = nil

local function homeWifiConnected()
    hs.audiodevice.defaultOutputDevice():setVolume(50)
    local _cmd = "sudo /usr/sbin/networksetup -setdnsservers 'Wi-Fi' " ..
                     secrets.networking.homeDNS
    hs.execute(_cmd)
    notification("Welcome home!", home_logo)
    _log("Connected to home WiFi")
end

local function workWifiConnected()
    hs.audiodevice.defaultOutputDevice():setVolume(0)
    local _cmd = "sudo /usr/sbin/networksetup -setdnsservers 'Wi-Fi' " ..
                     secrets.networking.publicDNS
    hs.execute(_cmd)
    notification("Welcome back to the office!")
    _log("Connected to work WiFi")
end

local function unknownWifiNetwork()
    hs.audiodevice.defaultOutputDevice():setVolume(0)
    local _cmd = "sudo /usr/sbin/networksetup -setdnsservers 'Wi-Fi' " ..
                     secrets.networking.publicDNS
    hs.execute(_cmd)
    notification("Unknown WiFi Network")
    _log("Connected to unknown WiFi")
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
        elseif newSSID ~= homeSSID and lastSSID == homeSSID or newSSID ~=
            workSSID and lastSSID == workSSID then
            -- Connected to unknown WiFi networ
            unknownWifiNetwork()
        end
    else
        return
    end

    lastSSID = newSSID
end

function networking.checkForLAN()
    if hs.network.interfaceDetails(v4) then
        for key, _ in pairs(hs.network.interfaceDetails(v4)) do
            if key == "AirPort" then return "wifi" end
        end
        return "lan"
    else
        return "none"
    end
end

function networking.disableWifiSlowly()
    sleep(15)
    hs.wifi.setPower(false)
    _log("Wifi disabled after being docked.")
end

--function networking.reconnectProxy()
--    _log("Reconnecting to proxy")
--
--    proxyPid = hs.execute("/usr/bin/pgrep autossh")
--
--    if proxyPid ~= "" then
--        hs.execute("/usr/bin/pgrep autossh | xargs /bin/kill -s SIGUSR1")
--        _log("SIGUSR1 sent to pid: " .. proxyPid .. " to restart proxy.")
--    elseif proxyPid == "" then
--        _log("No proxy running.")
--        _log("Killing off any errant autossh processes.")
--        hs.execute("killall autossh")
--
--        _log("Starting proxy.")
--        local conn = "localhost:" .. secrets.networking.proxyPort
--        local config = os.getenv("HOME") .. "/.ssh/config"
--        local args = {
--            "-M", "0", "-N", "-f", "-F", config, "-v", "-D", conn, "proxy"
--        }
--        local env = {AUTOSSH_DEBUG = "1", AUTOSSH_LOGFILE = "/tmp/autossh.log"}
--
--        local reconnect = hs.task.new("/opt/homebrew/bin/autossh",
--                                      executeHelpers.callback, args):waitUntilExit()
--        reconnect:setEnvironment(env)
--        reconnect:start()
--
--        proxyPid = reconnect:pid()
--        _log("Autossh started.")
--    end
--end

function networking.init()
    wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
    wifiWatcher:start()

    _log("Networking config loaded.")
end

return networking
