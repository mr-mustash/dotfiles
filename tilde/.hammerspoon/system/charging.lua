local charging = {}

local previousPowerState
local previousPowerStateTime

local function stopDocker()
    _log("Stopping docker containers.")

    for _, container in ipairs(secrets.charging.toggleContainers) do
        run.cmd("/usr/local/bin/docker", {"stop", container})
    end
    --for _, container in ipairs(secrets.charging.toggleContainers) do
    --    run.cmd("/usr/local/bin/docker", {"pause", container})
    --end
    _log("Not stopping docker containers due to them not really being compatible with M1.")
end

local function startDocker()
    _log("Starting docker containers.")

    for _, container in ipairs(secrets.charging.toggleContainers) do
        run.cmd("/usr/local/bin/docker", { "start", container })
    end
    notification("Docker Containers Started", docker_logo)
    --for _, container in ipairs(secrets.charging.toggleContainers) do
    --    run.cmd("/usr/local/bin/docker", {"unpause", container})
    --end
    --notification("Docker Containers Started", docker_logo)
    _log("Not starting docker containers due to them not really being compatible with M1.")
end

local function batteryPower()
    previousPowerState = "battery"
    debouncing = false
    previousPowerStateTime = os.time()
    _log("On battery power.")

    run.cmd("/usr/bin/tmutil", { "stopbackup" })
    run.brewcmd("maestral", { "pause" })

    display.setInternalBrightness(60)
    --stopDocker()
end

local function acPower()
    previousPowerState = "ac power"
    debouncing = false
    currentTime = os.time()
    _log("On AC Power: Full fully charged.")

    run.brewcmd("maestral", { "resume" })

    display.setInternalBrightness(90)
    --startDocker()
end

local function setPowerStateOnLoad()
    local currentPowerSource = hs.battery.powerSource()
    local currentBatteryPercentage = hs.battery.percentage()
    local charging = hs.battery.isCharging()
    previousPowerStateTime = os.time()

    if currentPowerSource == "Battery Power" then
        batteryPower()
    elseif currentPowerSource == "AC Power" then
        acPower()
    else
        _log("Something is broken in the battery module and we're not on AC or battery power.")
    end

    _log("Power state on load: " .. previousPowerState)
end

function powerStateChanged()
    local batPercent = math.floor(hs.battery.percentage())
    local currentPowerSource = hs.battery.powerSource()

    if currentPowerSource == "Battery Power" and previousPowerState ~= "battery" then
        batteryPower()
    elseif currentPowerSource == "AC Power" then
        acPower()
    end

    _log(
        "Battery currently at "
            .. string.format("%s", batPercent)
            .. "% and power state is "
            .. previousPowerState
            .. " and has been for "
            .. string.format("%s", os.time() - previousPowerStateTime)
            .. " seconds."
    )
end

function charging.init()
    local initStart = os.clock()

    setPowerStateOnLoad()

    batteryWatcher = hs.battery.watcher.new(powerStateChanged)
    batteryWatcher:start()

    _log("Charging config loaded in " .. os.clock() - initStart .. " seconds.")
end

return charging
