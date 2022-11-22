urls = {}

function urls.init()
    local initStart = os.clock()

    spoon.URLDispatcher:start()

    local builtin = appID(secrets.urls.builtin)
    local default = appID(secrets.urls.default)
    if Local.env == "work" then
        local meetings = appID(secrets.urls.meetings)
    else
        local meetings = appID(secrets.urls.default)
    end

    spoon.URLDispatcher.default_handler = default
    spoon.URLDispatcher.decode_slack_redir_urls = true
    spoon.URLDispatcher.set_system_handler = true

    spoon.URLDispatcher.url_patterns = {
        {"https://captive.apple.com/", builtin},
        {"https?://%w+.beatsense.com", builtin},
        {"https?://%w+.twitter.com/", builtin},
        {"https?://%w+.zoom.us/j/", meetings},
        {"https?://%w+w2g.tv", builtin},
        {"https?://twitter.com/", builtin},
        {"https?://w2g.tv", builtin},
        {"https?://www.beatsense.com", builtin},
        {"https?://zoom.us/j/", meetings},
    }

    _log(debug.getinfo(1, "S").short_src:gsub(".*/", "") .. " loaded in " .. (os.clock() - initStart) .. " seconds.")
end

return urls
