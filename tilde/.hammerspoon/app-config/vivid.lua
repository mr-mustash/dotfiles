local vivid = {}

function vivid.toggle()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.cmd, true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.alt, true):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.ctrl, true):post()
    hs.eventtap.event.newKeyEvent("v", true):post()
    hs.eventtap.event.newKeyEvent("v", false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.ctrl, false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.alt, false):post()
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.cmd, false):post()
end

function vivid.init()
    _log("Loaded Vivid.")
end

return vivid
