local run = {}

local function callback(exitCode, stdout, stderr)
    if exitCode ~= 0 then
        local logline = "EXECUTION ERROR: Command exited with code " .. exitCode
        if stdout ~= "" then
            logline = logline .. "\nstdout: " .. stdout
        end
        if stderr ~= "" then
            logline = logline .. "\nstderr: " .. stderr
        end

        _log(logline)
    end

    return exitCode
end

function run.brewcmd(command, args)
    -- Set homebrew binary path
    brewbin = "/opt/homebrew/bin"
    local _cmd = string.format("%s/%s", brewbin, command)

    run.cmd(_cmd, args)
end

function run.privileged(command)
    _log("Running " .. command .. " with sudo")
    local _sudoCommand = string.format('do shell script "%s 2>&1" with administrator privileges', command)

    if
        hs.dialog.blockAlert(
            "Hammerspoon Sudo",
            string.format("Attempting to run the following command as root: %s", _sudoCommand),
            "Allow",
            "Deny",
            "NSCriticalAlertStyle"
        ) == "Allow"
    then
        _log("Running " .. _sudoCommand)
        hs.osascript.applescript(_sudoCommand)
    else
        _log("Denyed " .. _sudoCommand)
    end
end

function run.cmd(command, args)
    local _cmd = string.format("%s", command)

    local f = io.open(_cmd, "r")
    if f == nil then
        _log("Command not found: " .. _cmd)
        return 1
    else
        io.close(f)
    end

    _log("Executing command: " .. _cmd)

    if args == nil then
        args = {}
    else
        _log("With args: " .. table.concat(args, " "))
    end

    local _execute = hs.task.new(_cmd, callback, args)

    _execute:start()
end

function run.startApp(application, isHidden)
    local app = application

    if isHidden == nil then
        isHidden = false
    end

    if hs.application.get(app) ~= nil then
        _log("Application " .. app .. " is already running")
        if isHidden == true then
            _log("Hiding " .. app .. " just to be sure.")
            hs.application.find(app):hide()
        end

        return
    end

    if isHidden == true then
        _log("Starting application hidden: " .. app)
        hs.application.open(app)
        running = hs.application.find(app)
        if running ~= nil then
            running:hide()
        else
            _log("Failed to hide " .. app)
        end
    else
        _log("Starting application: " .. app)
        local _app = hs.application.open(app, 5, true)
    end

    if running == nil then
        _log("Application not found: " .. app)
        return 1
    end
end

function run.closeApp(app)
    _log("Closing application: " .. app)
    local _app = hs.application.find(app)

    if _app == nil then
        _log("Application not found: " .. app)
        return 1
    end

    _app:kill()
end

function run.startApplication(app, is)
    _log("Starting application: " .. app)
    hs.application.launchOrFocus(app)
end

function run.init()
    _log("Loaded hs.task helper functions.")
end

return run
