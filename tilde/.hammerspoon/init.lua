---Init & Hammerspoon Config---
hs.logger.defaultLogLevel='debug'
local basePath = os.getenv("HOME") .. "/.hammerspoon/"
require("hs.crash")
hs.crash.crashLogToNSLog = false
hs.application.enableSpotlightForNameSearches(true) --Search for application names better
-------------------------------

------------GLOBALS------------
hyper = {'⌘', '⌥', 'ctrl'}
shyper = {'⌘', '⌥', '⇧', 'ctrl'}

-- Assets
home_logo = hs.image.imageFromPath(hs.configdir .. "/assets/king.png")
docker_logo = hs.image.imageFromPath(hs.configdir .. "/assets/docker.png")
spotify_logo = hs.image.imageFromPath(hs.configdir .. "/assets/spotify.png")
coffee_image = hs.image.imageFromPath(hs.configdir .. "/assets/coffee.png")
sleep_image = hs.image.imageFromPath(hs.configdir .. "/assets/sleep.png")

-- Audio Devices
headphoneOutput = "Patrick’s AirPods Pro"
speakerOutput = "MacBook Pro Speakers"
internalMic = "MacBook Pro Microphone"
externalMic = "Yeti X"

-- Global Functions
function notification(notification, image)
    if (image == nil or image == '') then
        hs.notify.new({title="Hammerspoon", informativeText=notification, withdrawAfter=3}):send()
    else
        hs.notify.new({title="Hammerspoon", informativeText=notification, setIdImage=image, withdrawAfter=3}):send()
    end
end

function sleep(n)
    hs.execute(("sleep " .. tonumber(n)))
end
-------------------------------

-- Load Spoons
hs.loadSpoon("Zoom")

-- Load my modules
audioControl = require "audioControl"
audioControl.init()

caffeine = require "caffeine"
caffeine.init()

charging = require "charging"
charging.init()

dock = require "dock"
dock.init()

networking = require "networking"
networking.init()

reload = require "reload"
reload.init()

spotifyconfig = require "spotifyconfig"
spotifyconfig.init()

zoomconfig = require "zoomconfig"
zoomconfig.init()
