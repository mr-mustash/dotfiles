ejectconfig = {}

function ejectconfig.init()
    local initStart = os.clock()

    spoon.EjectMenu.eject_on_lid_close = true
    spoon.EjectMenu.eject_on_sleep = true
    spoon.EjectMenu.notify = true
    spoon.EjectMenu.show_in_menubar = false

    spoon.EjectMenu:start()
    _log(debug.getinfo(1, "S").short_src:gsub(".*/", "") .. " loaded in " .. (os.clock() - initStart) .. " seconds.")
    _log("Eject config loaded.")

end

return ejectconfig
