local networking = {}

local wifiWatcher = nil
local homeSSID = secrets.networking.homeSSID
local workSSID = secrets.networking.workSSID
local phoneSSID = secrets.networking.phoneSSID
local officeSSID = secrets.networking.officeSSID
local lastSSID = "startup"

proxyPid = nil

function networking.networkReconnect(dns)
    -- Right after swapping interfaces the result can be nil. We want to retrun until it's not
    local defaultInterface = string.format("%s", hs.network.interfaceName(hs.network.primaryInterfaces()))
    while (defaultInterface == nil) do
        defaultInterface = string.format("%s", hs.network.interfaceName(hs.network.primaryInterfaces()))
        sleep(1)
    end

    local desiredDNS = string.format("%s", dns)
    local currentDNS = string.gsub(hs.execute(string.format("/usr/sbin/networksetup -getdnsservers '%s'", defaultInterface)),"\n","")

    if currentDNS ~= desiredDNS then
        _log("Need to change DNS to " .. desiredDNS .. " from " .. currentDNS)
        run.privileged(string.format("/usr/sbin/networksetup -setdnsservers '%s' %s", defaultInterface, desiredDNS))
    else
        _log("DNS is already " .. desiredDNS)
    end

    run.cmd("/usr/bin/dscacheutil", { "-flushcache" })
    run.cmd("/usr/bin/curl", {secrets.networking.link})
end

local function homeWifiConnected()
    hs.audiodevice.defaultOutputDevice():setVolume(50)

    networking.networkReconnect(secrets.networking.homeDNS)

    notification("Welcome home!", home_logo)
    _log("Connected to home WiFi")
end

local function phoneWifiConnected()
    hs.audiodevice.defaultOutputDevice():setVolume(0)
    networking.networkReconnect(secrets.networking.phoneDNS)
    sleep(1)
    notification("Teathered to Phone", phone_logo)
    _log("Connected to home WiFi")
end

local function workWifiConnected()
    hs.audiodevice.defaultOutputDevice():setVolume(50)

    networking.networkReconnect(secrets.networking.homeDNS)

    notification("Have a good day working from home!")
    _log("Connected to home work network")
end

local function officeWifiConnected()
    hs.audiodevice.defaultOutputDevice():setVolume(0)

    networking.networkReconnect("Empty")

    notification("Have a good day working from the office!", work_logo)
    _log("Connected to work WiFi")
end

local function unknownWifiNetwork()
    hs.audiodevice.defaultOutputDevice():setVolume(0)

    networking.networkReconnect(secrets.networking.publicDNS)

    notification("Unknown WiFi Network", coffee_image)
    _log("Connected to unknown WiFi")
end

local function captiveWifiNetwork()
    hs.audiodevice.defaultOutputDevice():setVolume(0)

    notification("Known captive network.")
    networking.networkReconnect("Empty")
    _log("Connected to known captive wifi network.", castle_image)

    -- Open the captive portal in a browser
    sleep(3)
    hs.osascript.applescript('tell application "Safari" to open location "http://captive.apple.com/"')
    sleep(1)
    hs.application.launchOrFocus("Safari.app")

end

local function captiveWifi(ssid)
    _log("Testing for captive SSID.")

    for _, s in ipairs(secrets.networking.captiveSSIDs) do
        if s == ssid then
            return true
        end
    end

    return false
end

local function ssidChangedCallback()
    local newSSID = hs.wifi.currentNetwork()

    if newSSID == lastSSID then
        _log("Reconnected to same network.")
        return 0
    end

    if newSSID ~= nil then
        _log("SSID changed to " .. newSSID .. " from " .. lastSSID .. ".")

        if newSSID == homeSSID then
            -- We just joined our home WiFi network
            homeWifiConnected()
        elseif newSSID == workSSID then
            -- Connected to work Wifi
            workWifiConnected()
        elseif newSSID == officeSSID then
            -- Connected to work Wifi
            officeWifiConnected()
        elseif newSSID == phoneSSID then
            -- Tethered to iPhone
            phoneWifiConnected()
        elseif captiveWifi(newSSID) == true then
            -- Captive wifi network
            captiveWifiNetwork()
        elseif newSSID ~= homeSSID or newSSID ~= workSSID or newSSID ~= phoneSSID then
            -- Connected to unknown WiFi networ
            unknownWifiNetwork()
        end
    else
        _log("No SSID found.")
        return
    end

    lastSSID = newSSID
end

function networking.checkForLAN()
    if hs.network.interfaceDetails(v4) then
        for key, _ in pairs(hs.network.interfaceDetails(v4)) do
            if key == "AirPort" then
                return "wifi"
            end
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

--TODO: refactor this to use `run.cmd` instead of `hs.execute`
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
--        local reconnect = hs.task.new("$brewbin/autossh",
--                                      executeHelpers.callback, args):waitUntilExit()
--        reconnect:setEnvironment(env)
--        reconnect:start()
--
--        proxyPid = reconnect:pid()
--        _log("Autossh started.")
--    end
--end

function networking.init()
    local initStart = os.clock()

    wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
    wifiWatcher:start()

    _log(debug.getinfo(1, "S").short_src:gsub(".*/", "") .. " loaded in " .. (os.clock() - initStart) .. " seconds.")
end

return networking
