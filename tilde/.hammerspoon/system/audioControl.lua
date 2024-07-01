local audioControl = {}

lastChangeTime = os.time()

local function internalOrExternalSpeaker()
    local speakers = hs.audiodevice.findOutputByName(secrets.audioControl.internalOutput)
    local headphones = hs.audiodevice.findOutputByName(secrets.audioControl.headphoneOutput)
    local monitor = hs.audiodevice.findOutputByName(secrets.audioControl.monitorOutput)

    if headphones then
        headphones:setDefaultOutputDevice()
        _log("Output changed to AirPods")
        return 0
    end

    if monitor then
        monitor:setDefaultOutputDevice()
        _log("Output device changed to LG HDR 5K")
        return 0
    end

    if speakers then
        speakers:setDefaultOutputDevice()
        _log("Output changed to internal speakers.")
        return 0
    end

    _log("Unable to set any speakers as default.")
    return 1
end

local function internalOrExternalMic()
    local internalMic = hs.audiodevice.findInputByName(secrets.audioControl.internalMic)
    local externalMic = hs.audiodevice.findInputByName(secrets.audioControl.externalMic)

    -- Use YetiX when docked
    if externalMic then
        externalMic:setDefaultInputDevice()
        _log("Mic changed to YetiX.")
        return 0
    end

    -- Internal mic when undocked
    if internalMic and not externalMic then
        internalMic:setDefaultInputDevice()
        _log("Mic changed to internal mic.")
        return 0
    end

    _log("Unable to set any mic as default")
    return 1
end
local function perDeviceWatcher(dev_uid, event_name, event_scope, event_element)
    local device = hs.audiodevice.findDeviceByUID(dev_uid)
    if device and event_name == "mute" then
        _log("\"" .. device:name() .. "\" mute state has changed.")
        audioControl.matchInputMuteToOutputMute()
        sleep(1)
    end
end

local function startOutputWatcher()
    local defaultOutput = hs.audiodevice.defaultOutputDevice()

    if defaultOutput:watcherIsRunning() then
        _log("Audio watcher for " .. defaultOutput:name() .. " already exists.")
    else
        _log("No audio watcher found for " .. defaultOutput:name() .. " starting one.")
        defaultOutput:watcherCallback(perDeviceWatcher)
        defaultOutput:watcherStart()
    end
end

local function audioDeviceChanged(arg)
    local outputRetval = 1
    local micRetval = 1

    LastSetOutputTime = os.time()

    -- Debounce audio device changes
    if arg == "dev#" and os.time() - lastChangeTime > 2 then
        -- This sleep here is a total hack. Without it macOS resets the default
        -- audio devices to what it things should be correct. What this usually
        -- means is that the mic on the AirPods is set as the default input
        -- instead of the built-in mic on the laptop.
        sleep(5)

        _log("New audio device detected. Current values: Speaker: " .. hs.audiodevice.defaultOutputDevice():name() .. " Mic: " .. hs.audiodevice.defaultInputDevice():name())
        startOutputWatcher()

        outputRetval = internalOrExternalSpeaker()
        micRetval = internalOrExternalMic()

        if outputRetval ~= 0 and micRetval ~= 0 then
            _log("Unable to set mic or speakers. Mic: " .. micRetval .. ", Speakers: " .. outputRetval)
        end
    end

end

local function trapVolumeControls()
    systemeventtap = hs.eventtap.new({ hs.eventtap.event.types.systemDefined }, function(mainEvent)
        local event = mainEvent:systemKey()
        local flags = hs.eventtap.checkKeyboardModifiers()
        if event["down"] == false or event["repeat"] == true then
            if hs.audiodevice.defaultOutputDevice():name() == secrets.audioControl.monitorOutput then
                    if event["key"] == "MUTE" or event["key"] == "SOUND_UP" or event["key"] == "SOUND_DOWN" then
                    _log("Trapped volume control and sending to external monitor.")
                    _log("Keycode: " .. event["key"] .. ", Monitor: " .. hs.audiodevice.defaultOutputDevice():name())

                    -- Send mute to external monitor if connected and it's the default audio output
                    if event["key"] == "MUTE" then
                        if hs.audiodevice.defaultOutputDevice():outputMuted() then
                            run.cmd("/Users/patrickking/bin/m1ddc", { "set", "mute", "off" })
                            _log("Unmuted external monitor.")
                        else
                            run.cmd("/Users/patrickking/bin/m1ddc", { "set", "mute", "on" })
                            _log("Muted external monitor.")
                        end
                        return true
                    end

                    -- Send volume up to external monitor if connected and it's the default audio output
                    if event["key"] == "SOUND_UP" then
                        run.cmd("/Users/patrickking/bin/m1ddc", { "chg", "volume", "+5" })
                        return true
                    end
                    if event["key"] == "SOUND_DOWN" then
                        run.cmd("/Users/patrickking/bin/m1ddc", { "chg", "volume", "-5" })
                        return true
                    end
                end
            end
        end
    end)

    systemeventtap:start()
end


function audioControl.mediaControls(key)
    hs.eventtap.event.newSystemKeyEvent(string.upper(key), true):post()
    hs.eventtap.event.newSystemKeyEvent(string.upper(key), false):post()
end

function audioControl.init()
    local initStart = os.clock()
    hs.audiodevice.watcher.setCallback(audioDeviceChanged)
    hs.audiodevice.watcher.start()
    startOutputWatcher()

    trapVolumeControls()
    hs.hotkey.bind({'cmd', 'shift'}, "k", function() audioControl.mediaControls("PLAY") end)
    hs.hotkey.bind({'cmd', 'shift'}, "j", function() audioControl.mediaControls("PREVIOUS") end)
    hs.hotkey.bind({'cmd', 'shift'}, "l", function() audioControl.mediaControls("NEXT") end)

    _log(debug.getinfo(1, "S").short_src:gsub(".*/", "") .. " loaded in " .. (os.clock() - initStart) .. " seconds.")
end

function audioControl.matchInputMuteToOutputMute()
    if hs.audiodevice.defaultOutputDevice():muted() then
        audioControl.muteInputs()
    else
        audioControl.unmuteInputs()
    end
end

function audioControl.muteInputs()
    for _, device in pairs(hs.audiodevice.allInputDevices()) do
        device:setInputMuted(true)
        if device:inputMuted() then
            _log(device:name() .. " muted")
        end
    end
end

function audioControl.unmuteInputs()
    for _, device in pairs(hs.audiodevice.allInputDevices()) do
        device:setInputMuted(false)
        if not device:inputMuted() then
            _log(device:name() .. " unmuted")
        end
    end
end

function audioControl.muteOutputs()
    for _, device in pairs(hs.audiodevice.allOutputDevices()) do
        if device:name() == secrets.audioControl.monitorOutput then
            run.cmd("/Users/patrickking/bin/m1ddc", { "set", "mute", "on" })
            _log("External display " .. device:name() .. " muted")
            return
        end

        device:setOutputMuted(true)
        if device:outputMuted() then
            _log(device:name() .. " muted")
        end
    end
end

function audioControl.unmuteOutputs()
    for _, device in pairs(hs.audiodevice.allOutputDevices()) do
        if device:name() == secrets.audioControl.monitorOutput then
            run.cmd("/Users/patrickking/bin/m1ddc", { "set", "mute", "off" })
            _log("External display " .. device:name() .. " unmuted")
            return
        end

        device:setOutputMuted(false)
        if not device:outputMuted() then
            _log(device:name() .. " unmuted")
        end
    end
end

return audioControl
