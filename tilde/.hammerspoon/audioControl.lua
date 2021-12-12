local audioControl = {}

-- Avoid automatically setting a bluetooth audio input device
lastSetDeviceTime = os.time()
lastInputDevice = nil

headphoneOutput = "Patrick’s AirPods Pro"
speakerOutput = "MacBook Pro Speakers"
internalMic = "MacBook Pro Microphone"
externalMic = "Yeti X"

local function internalOrExternalMic()
    local current = hs.audiodevice.defaultOutputDevice()
    local speakers = hs.audiodevice.findOutputByName(speakerOutput)
    local headphones = hs.audiodevice.findOutputByName(headphoneOutput)
    local internalMic = hs.audiodevice.findInputByName(internalMic)
    local externalMic = hs.audiodevice.findInputByName(externalMic)

    --if not speakers or not headphones then
    --    print(headphones)
    --    print(speakers)
    --    notification("ERROR: Some audio output devices are missing")
    --    return
    --end
    --if not internalMic or not externalMic then
    --    print(internalMic)
    --    print(externalMic)
    --    notification("ERROR: Some audio input devices are missing")
    --    return
    --end

    -- Internal mic when undocked
    if internalMic and not externalMic then
        internalMic:setDefaultInputDevice()
        print("Mic changed to internal mic.")
    end

    -- Use YetiX when docked
    if internalMic and externalMic then
        internalMic:setDefaultInputDevice()
        print("Mic changed to YetiX.")
    end
end

local function audioDeviceChanged(arg)
    if arg == 'dev#' or arg == 'dOut' then
        lastSetDeviceTime = os.time()
    elseif arg == 'dIn ' and os.time() - lastSetDeviceTime < 2 then
        inputDevice = hs.audiodevice.defaultInputDevice()
        internalOrExternalMic()
    end
    if hs.audiodevice.defaultInputDevice():transportType() ~= 'Bluetooth' then
        lastInputDevice = hs.audiodevice.defaultInputDevice()
    end
end


function audioControl.init()
    hs.audiodevice.watcher.setCallback(audioDeviceChanged)
    hs.audiodevice.watcher.start()
end

function audioControl.muteInputs()
    for _, device in pairs(hs.audiodevice.allInputDevices()) do
        device:setInputMuted(true)
        if device:inputMuted() then
            print(device:name() .. " muted")
        end
    end
end

function audioControl.unmuteInputs()
    for _, device in pairs(hs.audiodevice.allInputDevices()) do
        if device:inputMuted() then
            print(device:name() .. " unmuted")
        end
        device:setInputMuted(false)
    end
end

return audioControl
