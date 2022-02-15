local charging = {}

local previousPowerState
local previousPowerStateTime

local function stopDocker()
    _log("Stopping docker containers.")
    hs.execute(
        "sudo /usr/bin/renice 19 -p $(/usr/bin/pgrep com.apple.Virtualization.VirtualMachine)")

    for _, container in ipairs(secrets.charging.toggleContainers) do
        local cmd = "/usr/local/bin/docker stop " .. container
        hs.execute(cmd)
    end
end

local function startDocker()
    _log("Starting docker containers.")
    hs.execute("sudo /usr/bin/renice 5 -p $(/usr/bin/pgrep com.apple.Virtualization.VirtualMachine)")

    for _, container in ipairs(secrets.charging.toggleContainers) do
        local cmd = "/usr/local/bin/docker start " .. container
        hs.execute(cmd)
    end
    notification("Docker Containers Started", docker_logo)
end

local function batteryPower()
    previousPowerState = "battery"
    debouncing = false
    previousPowerStateTime = os.time()
    _log("On battery power.")

    hs.execute("tmutil stopbackup")

    display.setInternalBrightness(60)
    stopDocker()
end

local function acPowerFullyCharged()
    previousPowerState = "fullyCharged"
    debouncing = false
    currentTime = os.time()
    _log("On AC Power: Full fully charged.")

    display.setInternalBrightness(90)
    startDocker()
end

local function acPowerCharging()
    previousPowerState = "chargingNominal"
    previousPowerStateTime = os.time()
    _log("On AC Power: Charging.")

    display.setInternalBrightness(75)
    startDocker()
end

local function onWallPower()
    if previousPowerState == "battery" then
        -- Have to set this to something else than "battery" because
        -- onWallPower is called twice when plugging in and the state of
        -- hs.battery.isCharging() changes between the two calls.
        _log(
            "Plugged in after battery power. Entering post_bat to get get accurate power state.")
        previousPowerState = "post_bat"
        sleep(3)
        return
    end

    -- Checking for fully charged first
    if hs.battery.isCharged() == true and hs.battery.percentage == 100.0 -- Annoying, but hs.battery.isCharged() returns true even when the battery isn't at 100%
    and previousPowerState ~= "fullyCharged" then
        acPowerFullyCharged()
        return
    elseif hs.battery.isCharging() == true and hs.battery.percentage() <=
        99.0 and previousPowerState ~= "chargingNominal" then
        acPowerCharging()
        return
    else
        _log("Not changing power state. Current state: " ..
                 previousPowerState)
        return
    end

    _log(
        "Somehow we got here with no power state being met? This should never happen.")
end


function powerStateChanged()
    local batPercent = math.floor(hs.battery.percentage())
    local currentPowerSource = hs.battery.powerSource()

    if currentPowerSource == "Battery Power" and previousPowerState ~= "battery" then
        batteryPower()
    elseif currentPowerSource == "AC Power" then
        onWallPower()
    end

    _log("Battery currently at " .. string.format("%s", batPercent) ..
             "% and power state is " .. previousPowerState ..
             " and has been for " ..
             string.format("%s", os.time() - previousPowerStateTime) ..
             " seconds.")
end

function charging.init()
    batteryWatcher = hs.battery.watcher.new(powerStateChanged)
    chargingMenubarIndicator = hs.menubar.new(nil)

    batteryWatcher:start()

    _log("Charging config loaded.")
end

return charging
