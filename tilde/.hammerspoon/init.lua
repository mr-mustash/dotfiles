-- Important =============================================================== {{{
hs.logger.defaultLogLevel = "debug"
local basePath = os.getenv("HOME") .. "/.hammerspoon/"
require("hs.crash")
hs.crash.crashLogToNSLog = false
hs.application.enableSpotlightForNameSearches(true) -- Search for application names better
-- ========================================================================= }}}

-- Global Variables ======================================================== {{{
-- Load secrets first
require("secrets")

hyper = { "⌘", "⌥", "ctrl" }
shyper = { "⌘", "⌥", "⇧", "ctrl" }

-- Disable auto reload while testing
auto_reload = true

-- Assets
home_logo = hs.image.imageFromPath(hs.configdir .. "/assets/me.png")
docker_logo = hs.image.imageFromPath(hs.configdir .. "/assets/docker.png")
spotify_logo = hs.image.imageFromPath(hs.configdir .. "/assets/spotify.png")
coffee_image = hs.image.imageFromPath(hs.configdir .. "/assets/coffee.png")
sleep_image = hs.image.imageFromPath(hs.configdir .. "/assets/sleep.png")
phone_logo = hs.image.imageFromPath(hs.configdir .. "/assets/phone.jpg")

menubarStyle = { font = { name = "DejaVuSansMono Nerd Font Mono", size = 14 } }
menubarLargeStyle = { font = { name = "DejaVuSansMono Nerd Font Mono", size = 20 } }

defaultStyle = { font = { name = ".AppleSystemUIFont", size = 13 } }

-- ========================================================================= }}}

-- Global Functions ======================================================== {{{
function notification(notification, image)
    if image == nil or image == "" then
        hs.notify.new({
            title = "Hammerspoon",
            informativeText = notification,
            withdrawAfter = 5,
        }):send()
    else
        hs.notify.new({
            title = "Hammerspoon",
            informativeText = notification,
            contentImage = image,
            withdrawAfter = 5,
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

-- Important functions ===================================================== {{{
run = require("functions/run")
reload = require("functions/reload")

run.init()
reload.init()

-- ========================================================================= }}}
--
-- Load & Configure Spoons ================================================= {{{
hs.loadSpoon("URLDispatcher")

urls = require("spoon-config/urls")
urls.init()
-- ========================================================================= }}}

-- System Module Configuration ============================================= {{{
audioControl = require("system/audioControl")
caffeine = require("system/caffeine")
charging = require("system/charging")
display = require("system/display")
dock = require("system/dock")
networking = require("system/networking")
videoCalls = require("system/videoCalls")

audioControl.init()
caffeine.init()
charging.init()
display.init()
dock.init()
networking.init()
videoCalls.init()
-- ========================================================================= }}}

-- App configuration ======================================================= {{{
elgato = require("app-config/elgato")
stretchly = require("app-config/stretchly")

elgato.init()
stretchly.init()
-- ========================================================================= }}}

---------- testing ------------
-- applicationEventMap = {
--    [hs.application.watcher.activated] = "activated",
--    [hs.application.watcher.deactivated] = "deactivated",
--    [hs.application.watcher.hidden] = "hidden",
--    [hs.application.watcher.launched] = "launched",
--    [hs.application.watcher.launching] = "launching",
--    [hs.application.watcher.terminated] = "terminated",
--    [hs.application.watcher.unhidden] = "unhidden",
-- }
--
-- applicationsWatcher = hs.application.watcher.new(function(name, type, app)
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
-- end)
--
-- applicationsWatcher:start()
