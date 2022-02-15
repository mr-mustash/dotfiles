local audioControl = {}

-- Avoid automatically setting a bluetooth audio input device
lastChangeTime = os.time()
lastInputDevice = hs.audiodevice.defaultInputDevice()
lastOutputDevice = hs.audiodevice.defaultOutputDevice()

local function internalOrExternalSpeaker()
    local speakers = hs.audiodevice.findOutputByName(
                         secrets.audioControl.internalOutput)
    local headphones = hs.audiodevice.findOutputByName(
                           secrets.audioControl.headphoneOutput)
    local monitor = hs.audiodevice.findOutputByName(
                        secrets.audioControl.monitorOutput)

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
    local internalMic = hs.audiodevice.findInputByName(
                            secrets.audioControl.internalMic)
    local externalMic = hs.audiodevice.findInputByName(
                            secrets.audioControl.externalMic)

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
            _log("Unable to set mic or speakers. Mic: " .. mRetval ..
                     ", Speakers: " .. sRetval)
        end
    end
end

function audioControl.init()
    -- TODO: Set up something like https://gist.github.com/waydabber/3241fc146cef65131a42ce30e4b6eab7#file-ddcavcontrol-init-lua-L145 to control external display's speakers.
    hs.audiodevice.watcher.setCallback(audioDeviceChanged)
    hs.audiodevice.watcher.start()

    _log("Audio control config loaded.")
end

function audioControl.muteInputs()
    for _, device in pairs(hs.audiodevice.allInputDevices()) do
        device:setInputMuted(true)
        if device:inputMuted() then _log(device:name() .. " muted") end
    end
end

function audioControl.unmuteInputs()
    for _, device in pairs(hs.audiodevice.allInputDevices()) do
        device:setInputMuted(false)
        if not device:inputMuted() then _log(device:name() .. " unmuted") end
    end
end

function audioControl.muteOutputs()
    for _, device in pairs(hs.audiodevice.allOutputDevices()) do
        if device:name() == secrets.audioControl.monitorOutput then
            hs.execute("/opt/homebrew/bin/ddcctl -d 1- -m 1")
            _log("External display " .. device:name() .. " muted")
            return
        end

        device:setOutputMuted(true)
        if device:outputMuted() then _log(device:name() .. " muted") end
    end
end

function audioControl.unmuteOutputs()
    for _, device in pairs(hs.audiodevice.allOutputDevices()) do
        if device:name() == secrets.audioControl.monitorOutput then
            hs.execute("/opt/homebrew/bin/ddcctl -d 1- -m 2")
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
