-- Important =============================================================== {{{
hs.logger.defaultLogLevel = "debug"
local basePath = os.getenv("HOME") .. "/.hammerspoon/"
require("hs.crash")
hs.crash.crashLogToNSLog = false
hs.application.enableSpotlightForNameSearches(true) --Search for application names better
-- ========================================================================= }}}

-- Global Variables ======================================================== {{{

hyper = { "⌘", "⌥", "ctrl" }
shyper = { "⌘", "⌥", "⇧", "ctrl" }

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

-- ========================================================================= }}}

-- Global Functions ======================================================== {{{
function notification(notification, image)
    if image == nil or image == "" then
        hs.notify.new({ title = "Hammerspoon", informativeText = notification, withdrawAfter = 3 }):send()
    else
        hs.notify.new({
            title = "Hammerspoon",
            informativeText = notification,
            contentImage = image,
            withdrawAfter = 3,
        }):send()
    end
end

function getFunctionLocation()
    local w = debug.getinfo(3, "S")
    return w.short_src:gsub(".*/", "") .. ":" .. w.linedefined
end

function _log(message)
    local location = getFunctionLocation()
    print(location .. ": " .. message)
end

function sleep(n)
    hs.execute(("sleep " .. tonumber(n)))
end

function appID(app)
    return hs.application.infoForBundlePath(app)["CFBundleIdentifier"]
end
-- ========================================================================= }}}

-- Load & Configure Spoons ================================================= {{{
hs.loadSpoon("EjectMenu")
hs.loadSpoon("URLDispatcher")
hs.loadSpoon("Zoom")

eject = require("spoon-config/eject")
urls = require("spoon-config/urls")
eject.init()
urls.init()
-- ========================================================================= }}}

-- System Module Configuration ============================================= {{{
audioControl = require("system/audioControl")
caffeine = require("system/caffeine")
charging = require("system/charging")
display = require("system/display")
dock = require("system/dock")
networking = require("system/networking")

audioControl.init()
caffeine.init()
charging.init()
display.init()
dock.init()
networking.init()
-- ========================================================================= }}}

-- App configuration ======================================================= {{{
spotifyconfig = require("app-config/spotifyconfig")
stretchly = require("app-config/stretchly")
zoomconfig = require("app-config/zoomconfig")

spotifyconfig.init()
stretchly.init()
zoomconfig.init()
-- ========================================================================= }}}

-- Misc functions ========================================================== {{{
reload = require("functions/reload")
reload.init()
-- ========================================================================= }}}

---------- testing ------------
--applicationEventMap = {
--    [hs.application.watcher.activated] = "activated",
--    [hs.application.watcher.deactivated] = "deactivated",
--    [hs.application.watcher.hidden] = "hidden",
--    [hs.application.watcher.launched] = "launched",
--    [hs.application.watcher.launching] = "launching",
--    [hs.application.watcher.terminated] = "terminated",
--    [hs.application.watcher.unhidden] = "unhidden",
--}
--
--applicationsWatcher = hs.application.watcher.new(function(name, type, app)
--    local title = ""
--    local windowTitle = ""
--    if app ~= nil then
--        title = app:title()
--        if title == nil then
--            title = "nil"
--        end
--        local focusedWindow = app:focusedWindow()
--        if focusedWindow ~= nil then
--            windowTitle = focusedWindow:title()
--        end
--    end
--    hs.timer.doAfter(1, function() _log(appHistory, "[" .. name .. " - " .. title .. "] " .. " [" .. windowTitle .. "] [" .. applicationEventMap[type] .. "]") end)
--end)
--
--applicationsWatcher:start()
