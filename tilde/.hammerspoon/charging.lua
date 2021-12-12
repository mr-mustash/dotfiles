local charging = {}

local batteryAbove = false
local PreviousPowerSource = hs.battery.powerSource()

local function stopDocker()
    hs.execute("sudo /usr/bin/renice 19 -p $(/usr/bin/pgrep com.docker.hyperkit)")
    hs.execute("/usr/local/bin/docker ps -q > ~/.docker_stopped_containers")
    hs.execute("/usr/local/bin/docker stop $(/usr/local/bin/docker ps -q)")
end

local function startDocker()
    hs.execute("cat ~/.docker_stopped_containers | xargs /usr/local/bin/docker start")
    hs.execute("sudo /usr/bin/renice 5 -p $(/usr/bin/pgrep com.docker.hyperkit)")
    notification("Docker Containers Started", docker_logo)
end

local function whenBatteryAbove50()
    if hs.battery.percentage() >= 50.0 and hs.battery.isCharging() and batteryAbove == false then
        print("Battery above 50 percent.")
        batteryAbove = true -- Set this we only run this once
        hs.brightness.set(90)
        hs.execute("sudo /sbin/kextunload /Applications/tbswitcher_resources/DisableTurboBoost.64bits.kext")
        startDocker()
    end
end

local function powerStateChanged()
    -- Always check to see if battery above 50%
    whenBatteryAbove50()

    CurrentPowerSource = hs.battery.powerSource()
    if CurrentPowerSource ~= PreviousPowerSource then
        if CurrentPowerSource == "Battery Power" then
            print("On battery power")
            hs.execute("tmutil stopbackup")
            hs.execute("pgrep -i Dropbox | xargs renice 19")
            hs.execute("pgrep -i protonmail | xargs renice 19")
            hs.brightness.set(50)
            -- Set batteryAbove to false so that we execute whenBatteryAbove50()
            -- only once when back on battery power
            batteryAbove = false
            stopDocker()
            hs.execute("sudo /sbin/kextload /Applications/tbswitcher_resources/DisableTurboBoost.64bits.kext")
        end
        if CurrentPowerSource == "AC Power" then
            print("On AC power")
            hs.execute("pgrep -i Dropbox | xargs sudo renice 5")
            hs.execute("pgrep -i protonmail | xargs renice 5")
            if hs.battery.percentage() >= 50.0 then
                batteryAbove = true -- Set so we don't execute whenBatteryAbove50()
                hs.brightness.set(90)
                hs.execute("sudo /sbin/kextunload /Applications/tbswitcher_resources/DisableTurboBoost.64bits.kext")
                startDocker()
            else
                hs.brightness.set(75)
                print("Not starting Docker as battery is too low.")
                hs.execute("sudo /sbin/kextload /Applications/tbswitcher_resources/DisableTurboBoost.64bits.kext")
                batteryAbove = false
            end
        end
        PreviousPowerSource = CurrentPowerSource
    end
end

function charging.init()
    batteryWatcher = hs.battery.watcher.new(powerStateChanged)
    batteryWatcher:start()
end

return charging
