local turboBoost = {}

function turboBoost.enable()
    hs.execute("sudo /sbin/kextunload /Applications/tbswitcher_resources/DisableTurboBoost.64bits.kext")

    script = os.getenv("HOME") .. "/.applescript/fan-performance.applescript"
    hs.osascript.applescriptFromFile(script)

    _log("Turbo Boost enabled.")
end

function turboBoost.disable()
    if dock.isDocked() == false then
        script = os.getenv("HOME") .. "/.applescript/fan-silent.applescript"
    else
        _log("We are docked, so we don't want to disable the fan.")
        script = os.getenv("HOME") .. "/.applescript/fan-performance.applescript"
    end

    hs.osascript.applescriptFromFile(script)
    hs.execute("sudo /sbin/kextload /Applications/tbswitcher_resources/DisableTurboBoost.64bits.kext")
    _log("Turbo Boost disabled.")
end

function turboBoost.init()
    local initStart = os.clock()
    _log(debug.getinfo(1, "S").short_src:gsub(".*/", "") .. " loaded in " .. (os.clock() - initStart) .. " seconds.")
end

return turboBoost
