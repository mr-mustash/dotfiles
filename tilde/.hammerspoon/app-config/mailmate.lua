local mailmate = {}

local function mailmateCall(name, eventType, app)
    if name == "MailMate" and eventType == hs.application.watcher.launched then
        _log("Mailmate started")
        for _, app in ipairs(secrets.mail.companionApps) do
            _log(string.format("Launching %s for mailmate", app))
            run.startApp(app, true)
        end
    end

    if name == "MailMate" and eventType == hs.application.watcher.terminated then
        _log("Stretchly closed")
        for _, app in ipairs(secrets.mail.companionApps) do
            _log(string.format("Closing %s after closing mailmate", app))
            run.startApp(app, true)
        end
    end
end

function mailmate.init()
    local initStart = os.clock()

    mailmateWatcher = hs.application.watcher.new(mailmateCall)
    mailmateWatcher:start()
    _log(debug.getinfo(1, "S").short_src:gsub(".*/", "") .. " loaded in " .. (os.clock() - initStart) .. " seconds.")
end

return mailmate
