-- Important =============================================================== {{{

hs.logger.defaultLogLevel = "debug"
local basePath = os.getenv("HOME") .. "/.hammerspoon/"
require("hs.crash")
hs.crash.crashLogToNSLog = false
hs.application.enableSpotlightForNameSearches(true) -- Search for application names better
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

function File_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then io.close(f) return true else return false end
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

-- Global Variables ======================================================== {{{
-- Load secrets first

if File_exists(basePath .. "local.lua") then
    require("local")
end

if File_exists(basePath .. "secrets.lua") then
    require("secrets")
end

hyper = { "⌘", "⌥", "ctrl" }
shyper = { "⌘", "⌥", "⇧", "ctrl" }

-- Disable auto reload while testing
auto_reload = true

-- Assets
castle_image = hs.image.imageFromPath(hs.configdir .. "/assets/castle.png")
coffee_image = hs.image.imageFromPath(hs.configdir .. "/assets/coffee.png")
docker_logo = hs.image.imageFromPath(hs.configdir .. "/assets/docker.png")
home_logo = hs.image.imageFromPath(hs.configdir .. "/assets/me.png")
phone_logo = hs.image.imageFromPath(hs.configdir .. "/assets/phone.jpg")
sleep_image = hs.image.imageFromPath(hs.configdir .. "/assets/sleep.png")
spotify_logo = hs.image.imageFromPath(hs.configdir .. "/assets/spotify.png")
work_logo = hs.image.imageFromPath(hs.configdir .. "/assets/replicant.png")
island_image = hs.image.imageFromPath(hs.configdir .. "/assets/island.png")

menubarStyleTiny = { font = { name = "DejaVuSansMono Nerd Font Mono", size = 8 } }
menubarStyle = { font = { name = "DejaVuSansMono Nerd Font Mono", size = 14 } }
menubarLargeStyle = { font = { name = "DejaVuSansMono Nerd Font Mono", size = 20 } }

defaultStyle = { font = { name = ".AppleSystemUIFont", size = 13 } }

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
Dock = require("system/dock")
networking = require("system/networking")
-- Ping = require("system/Ping") -- needs work
videoCalls = require("system/videoCalls")


audioControl.init()
caffeine.init()
charging.init()
display.init()
Dock.init()
networking.init()
-- Ping.init() -- needs work
videoCalls.init()
-- ========================================================================= }}}

-- App configuration ======================================================= {{{
Elgato = require("app-config/elgato")
Mailmate = require("app-config/mailmate")
--Moviest = require("app-config/moviest")
Stretchly = require("app-config/stretchly")
--Vivid = require("app-config/vivid")
Zoom = require("app-config/zoom")

Elgato.init()
Mailmate.init()
--Moviest.init()
Stretchly.init()
--Vivid.init()
Zoom.init()
-- ========================================================================= }}}

-- Always have at the end
notification("Config reload finished.")

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
