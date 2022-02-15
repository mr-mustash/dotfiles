local display = {}

function display.setInternalBrightness(brightness)
    local _brightness = brightness / 100
    for _, display in pairs(hs.screen.allScreens()) do
        if display:name() == "Built-in Retina Display" then
            _log("Setting " .. display:name() .. " brightness to " .. brightness)
            display:setBrightness(_brightness)
        end
    end
end

function display.setAllBrightness(brightness)
    local _brightness = brightness / 100
    for _, display in pairs(hs.screen.allScreens()) do
        if display:name() == "Built-in Retina Display" then
            _log("Setting " .. display:name() .. " brightness to " .. brightness)
            display:setBrightness(_brightness)
        else
            _log("Setting " .. display:name() .. " brightness to " .. brightness)
            -- Use ddcctl to set the brightness of all external displays
            local cmd = "/opt/homebrew/bin/ddcctl -d 1 -b " .. brightness
            hs.execute(cmd)
        end
    end
end

function display.init()
    _log("Display config loaded.")
end

return display
