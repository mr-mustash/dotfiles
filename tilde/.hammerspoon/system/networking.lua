local networking = {}

local wifiWatcher = nil
local homeSSID = secrets.networking.homeSSID
local homeOfficeSSID = secrets.networking.workSSID
local phoneSSID = secrets.networking.phoneSSID
local officeSSID = secrets.networking.officeSSID
local travelSSID = secrets.networking.travelSSID
local lastSSID = "startup"

function networking.setDNS(dns)
    -- Right after swapping interfaces the result can be nil. We want to rerun
    -- until it's not
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
end

local function detectCaptivePortal()
    detectCaptive, retval, _, _ = hs.execute("/usr/bin/curl -s http://captive.apple.com/hotspot-detect.html | /opt/homebrew/bin/w3m -dump -T text/html")
    if not retval then
        _log("Captive portal detection command failed. Assuming no captive portal is present.")
        return 1
    end

    -- Remove newline
    detectCaptive = detectCaptive:gsub("\n[^\n]*$", "")

    if detectCaptive == "Success" then
        _log("Captive portal detected.")
        return 0
    else
        _log("No captive portal detected.")
        return 1
    end
end

local function captiveWifiNetwork()
    notification("Captive portal detected on network.", castle_image)

    networking.setDNS("Empty")

    -- Open the captive portal in a browser
    hs.osascript.applescript('tell application "Safari" to open location "http://captive.apple.com/"')
    sleep(3)
    hs.application.launchOrFocus("Safari.app")

    return
end

function networking.networkReconnect(dns)
    -- Being connected to a VPN messes this process up as it changes the default
    -- interface. So we need to disconnect from the VPN before we can reconnect
    if hs.application.find("Passepartout") ~= nil then
        _log("Disabling VPN for network reconnection.")

        hs.shortcuts.run("VPN Off")
        sleep(1)
        hs.application.find("Passepartout"):hide()
    end

    -- Before setting the desired DNS we need to check for a captive portal. If
    -- we detect one we set the DNS to "empty" so we can use the local network
    -- resolver and navigate to the captive Portal.
    if (detectCaptivePortal() == 0 and (hs.wifi.currentNetwork() ~= homeSSID or hs.wifi.currentNetwork() ~= homeOfficeSSID)) then
        captiveWifiNetwork()
    end

    -- Set the desired DNS server
    networking.setDNS(dns)

    -- Enable VPN again.
    if hs.application.find("Passepartout") ~= nil then
        _log("Enabling VPN after network reconnection.")

        hs.shortcuts.run("VPN On")
        sleep(1)
        hs.application.find("Passepartout"):hide()
    end
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

    notification("Teathered to Phone", phone_logo)
    _log("Connected to home WiFi")
end

local function homeOfficeWifiConnected()
    hs.audiodevice.defaultOutputDevice():setVolume(50)

    networking.networkReconnect(secrets.networking.homeDNS)

    notification("Have a good day working from home!")
    _log("Connected to home work network")
end

local function officeWifiConnected()
    hs.audiodevice.defaultOutputDevice():setVolume(0)

    networking.networkReconnect(secrets.networking.publicDNS)

    notification("Have a good day working from the office!", work_logo)
    _log("Connected to office WiFi")
end

local function travelWifiConnected()
    hs.audiodevice.defaultOutputDevice():setVolume(0)

    networking.networkReconnect(secrets.networking.publicDNS)

    notification("Have fun on your vacation!", island_image)
    _log("Connected to travel router.")
end

local function unknownWifiNetwork()
    hs.audiodevice.defaultOutputDevice():setVolume(0)

    networking.networkReconnect(secrets.networking.publicDNS)

    notification("Unknown WiFi Network", coffee_image)
    _log("Connected to unknown WiFi")
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
        elseif newSSID == homeOfficeSSID then
            -- Connected to work Wifi
            homeOfficeWifiConnected()
        elseif newSSID == officeSSID then
            -- Connected to office Wifi
            officeWifiConnected()
        elseif newSSID == phoneSSID then
            -- Tethered to iPhone
            phoneWifiConnected()
        elseif newSSID == travelSSID then
            -- Connected to travel router
            travelWifiConnected()
        else
            -- Connected to unknown WiFi network
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

function networking.init()
    local initStart = os.clock()

    wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
    wifiWatcher:start()

    _log(debug.getinfo(1, "S").short_src:gsub(".*/", "") .. " loaded in " .. (os.clock() - initStart) .. " seconds.")
end

return networking
