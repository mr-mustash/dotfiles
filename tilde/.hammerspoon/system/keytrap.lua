local keytrap = {}

local function keytrap_router()
    systemeventtap = hs.eventtap.new({ hs.eventtap.event.types.systemDefined }, function(mainEvent)
        local event = mainEvent:systemKey()
        local flags = hs.eventtap.checkKeyboardModifiers()

    end)
    systemeventtap:start()
end

function keytrap.init()
    keytrap_router()
end

return keytrap
