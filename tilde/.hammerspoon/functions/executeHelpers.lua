local executeHelpers = {}

function executeHelpers.callback(exitCode, stdout, stderr)
    local w = debug.getinfo(2, "S")
    if w == nil then
        _log(
            "Error: No previous function call found in executeHelpers.callback()")
        return
    end
    local location = w.short_src:gsub(".*/", "") .. ":" .. w.linedefined

    local logline = "Command from " .. location .. " exited with code " ..
                        exitCode
    if stdout ~= "" then logline = logline .. "\nstdout: " .. stdout end
    if stderr ~= "" then logline = logline .. "\nstderr: " .. stderr end

    _log(logline)
end

function executeHelpers.init() _log("Loaded hs.execute helper functions.") end

return executeHelpers
