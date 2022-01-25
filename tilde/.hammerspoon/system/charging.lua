local charging = {}

local previousPowerState = ""
local previousPowerStateTime = os.time()

local function stopDocker()
    _log("Pausing docker containers.")
    hs.execute("sudo /usr/bin/renice 19 -p $(/usr/bin/pgrep com.docker.hyperkit)")
    hs.execute("/usr/local/bin/docker ps -q | /usr/bin/xargs /usr/local/bin/docker pause ")
end

local function startDocker()
    _log("Starting docker containers.")
    hs.execute("sudo /usr/bin/renice 5 -p $(/usr/bin/pgrep com.docker.hyperkit)")
    hs.execute("/usr/local/bin/docker ps -q | /usr/bin/xargs /usr/local/bin/docker unpause ")
    notification("Docker Containers Started", docker_logo)
end

local function batteryPower()
    previousPowerState = "battery"
    previousPowerStateTime = os.time()
    _log("On battery power.")

    hs.execute("tmutil stopbackup")
    -- hs.execute("/usr/local/bin/maestral pause")

    display.setInternalBrightness(60)
    stopDocker()
    hs.execute("sudo /sbin/kextload /Applications/tbswitcher_resources/DisableTurboBoost.64bits.kext")
end

local function acPowerFullSpeedNominal()
    previousPowerState = "chargingNominal"
    previousPowerStateTime = os.time()
    _log("On AC Power: Full speed charging.")

    display.setInternalBrightness(90)
    hs.execute("sudo /sbin/kextunload /Applications/tbswitcher_resources/DisableTurboBoost.64bits.kext")
    -- hs.execute("/usr/local/bin/maestral resume")
    startDocker()
end

local function acPowerFullSpeedLowBat()
    previousPowerState = "chargingLowBat"
    previousPowerStateTime = os.time()
    _log("On AC Power: Full speed charging. Low battery.")

    display.setInternalBrightness(75)
    hs.execute("sudo /sbin/kextload /Applications/tbswitcher_resources/DisableTurboBoost.64bits.kext")
    -- hs.execute("/usr/local/bin/maestral resume")
    stopDocker()
end

local function acPowerTrickle()
    previousPowerState = "trickle"
    previousPowerStateTime = os.time()
    _log("On AC Power: Trickle charging.")

    display.setInternalBrightness(60)
    hs.execute("sudo /sbin/kextload /Applications/tbswitcher_resources/DisableTurboBoost.64bits.kext")
    -- hs.execute("/usr/local/bin/maestral resume")
    stopDocker()
end

local function onWallPower()
    if hs.battery.isCharging() or hs.battery.isCharged() then
        if os.time() - previousPowerStateTime > 600 then
            if hs.battery.percentage() >= 50.0 and previousPowerState ~= "chargingNominal" then
                acPowerFullSpeedNominal()
            elseif hs.battery.percentage() < 50.0 and previousPowerState ~= "chargingLowBat" then
                acPowerFullSpeedLowBat()
            end
        else
            _log("On AC Power: Battery is charging, but debouncing between charging and trickle charging.")
            _log("Seconds remaining on debounce: " .. 600 - (os.time() - previousPowerStateTime))
        end
    elseif not hs.battery.isCharging() and previousPowerState ~= "trickle" then
        acPowerTrickle()
    end
end

function powerStateChanged()
    local batPercent = math.floor(hs.battery.percentage())
    _log("Battery currently at " .. string.format("%s", batPercent) .. "%")

    if hs.battery.isCharged() and CurrentPowerSource == "Battery Power" then
        -- Special case for when the battery is charged and we plug in AC power
        -- after the hammerspoon state has been reset.
        _log("On AC Power: Battery is fully charged. Skipping `onWallPower` checks.")
        acPowerFullSpeed()
    else
        CurrentPowerSource = hs.battery.powerSource()
        if CurrentPowerSource == "Battery Power" and previousPowerState ~= "battery" then
            batteryPower()
        elseif CurrentPowerSource == "AC Power" then
            onWallPower()
        end
    end
end

function charging.init()
    batteryWatcher = hs.battery.watcher.new(powerStateChanged)
    batteryWatcher:start()

    _log("Charging config loaded.")
end

return charging
