local audioControl = {}

-- Avoid automatically setting a bluetooth audio input device
lastChangeTime = os.time()
lastInputDevice = hs.audiodevice.defaultInputDevice()
lastOutputDevice = hs.audiodevice.defaultOutputDevice()

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

local function audioDeviceChanged(arg)
    local sRetval = 1
    local mRetval = 1
    if arg == "dev#" and os.time() - lastChangeTime > 2 then
        sRetval = internalOrExternalSpeaker()
        mRetval = internalOrExternalMic()

        if sRetval == 0 and mRetval == 0 then
            lastSetOutputTime = os.time()
        else
            _log("Unable to set mic or speakers. Mic: " .. mRetval .. ", Speakers: " .. sRetval)
        end
    end
end

local function trapVolumeControls()
    systemeventtap = hs.eventtap.new({ hs.eventtap.event.types.systemDefined }, function(mainEvent)
        local event = mainEvent:systemKey()
        local flags = hs.eventtap.checkKeyboardModifiers()
        if event["down"] == false or event["repeat"] == true then
            if hs.audiodevice.defaultOutputDevice():name() == secrets.audioControl.monitorOutput then
                _log("Trapped volume control and sending to external monitor.")
                _log("Keycode: " .. event["key"] .. ", Monitor: " .. hs.audiodevice.defaultOutputDevice():name())

                -- Send mute to external monitor if connected and it's the default audio output
                if event["key"] == "MUTE" then
                    if isMuted == false then
                        isMuted = true
                        run.cmd("/Users/patrickking/bin/m1ddc", { "set", "mute", "on" })
                        _log("Muted external monitor.")
                    else
                        isMuted = false
                        run.cmd("/Users/patrickking/bin/m1ddc", { "set", "mute", "off" })
                        _log("Unmuted external monitor.")
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
    end)

    systemeventtap:start()
end

function audioControl.init()
    local initStart = os.clock()
    hs.audiodevice.watcher.setCallback(audioDeviceChanged)
    hs.audiodevice.watcher.start()

    trapVolumeControls()

    _log(debug.getinfo(1, "S").short_src:gsub(".*/", "") .. " loaded in " .. (os.clock() - initStart) .. " seconds.")
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
