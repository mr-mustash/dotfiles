urls = {}

function urls.init()
    local initStart = os.clock()

    spoon.URLDispatcher:start()

    local builtin = appID(secrets.urls.builtin)
    local default = appID(secrets.urls.default)
    local personal
    local meetings
    local chat

    if Local.env == "work" then
        meetings = appID(secrets.urls.meetings)
        personal = appID(secrets.urls.personal)
        chat     = secrets.urls.chat -- Just need the application name, not the appID
    else
        local meetings = appID(secrets.urls.default)
    end

    spoon.URLDispatcher.default_handler = default
    spoon.URLDispatcher.decode_slack_redir_urls = true
    spoon.URLDispatcher.set_system_handler = true

    -- Add work specific application URL Patterns

    spoon.URLDispatcher.url_patterns = {
        {"https://captive.apple.com/", builtin},
        {"https?://%w+.beatsense.com", builtin},
        {"https?://%w+.twitter.com/", builtin},
        {"https?://%w+.zoom.us/j/", meetings},
        {"https?://%w+.tiktok.com", builtin},
        {"https?://%w+.w2g.tv", builtin},
        {"https?://tiktok.com", builtin},
        {"https?://twitter.com/", builtin},
        {"https?://w2g.tv", builtin},
        {"https?://www.beatsense.com", builtin},
        {"https?://zoom.us/j/", meetings},
    }

    if Local.env == "work" then
        table.insert(spoon.URLDispatcher.url_patterns, {"https?://.*", personal, nil, chat})
    end

    --if Local.env == "work" then table.insert(spoon.URLDispatcher.url_patterns,
    --{"https?://.*", personal, nil, "Discord"}) end

    _log(debug.getinfo(1, "S").short_src:gsub(".*/", "") .. " loaded in " .. (os.clock() - initStart) .. " seconds.")
end

return urls
