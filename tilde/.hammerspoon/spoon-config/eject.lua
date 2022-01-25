ejectconfig = {}

function ejectconfig.init()
    spoon.EjectMenu:start()

    spoon.EjectMenu.eject_on_lid_close = true
    spoon.EjectMenu.eject_on_sleep = true
    spoon.EjectMenu.notify = true
    spoon.EjectMenu.show_in_menubar = false

    _log("Eject config loaded.")
end

return ejectconfig
