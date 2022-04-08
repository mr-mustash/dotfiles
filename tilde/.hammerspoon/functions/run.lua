local run = {}

local function callback(exitCode, stdout, stderr)
    if exitCode ~= 0 then
        local logline = "EXECUTION ERROR: Command exited with code " .. exitCode
        if stdout ~= "" then logline = logline .. "\nstdout: " .. stdout end
        if stderr ~= "" then logline = logline .. "\nstderr: " .. stderr end

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

function run.cmd(command, args)
    local _cmd = string.format("%s", command)

    local f = io.open(_cmd,"r")
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
        _log("With args: " .. table.concat(args))
    end

    local _execute = hs.task.new(_cmd, callback, args)

    _execute:start()
end

function run.init() _log("Loaded hs.task helper functions.") end

return run
