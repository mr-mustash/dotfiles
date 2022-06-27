urls = {}

function urls.init()
    local initStart = os.clock()

    spoon.URLDispatcher:start()

    local workBrowser = appID(secrets.urls.workBrowser)
    local safari = appID(secrets.urls.safari)
    local personalBrowser = appID(secrets.urls.personalBrowser)
    local videoCallBrowser = appID(secrets.urls.workBrowser)
    local videoPlayer = appID(secrets.urls.workBrowser)
    --local vpn = appID(secrets.urls.vpn)
    --local meetings = appID(secrets.urls.meetings)

    spoon.URLDispatcher.default_handler = workBrowser
    spoon.URLDispatcher.decode_slack_redir_urls = true
    spoon.URLDispatcher.set_system_handler = true

    spoon.URLDispatcher.url_patterns = {
        --{"https?://%w+.zoom.us/j/", meetings},
        --{"https?://zoom.us/j/", meetings},
        { "https?://%w+.app.datadoghq.com", workBrowser },
        { "https?://%w+.atlassian.net", workBrowser },
        { "https?://%w+.datadoghq.com", workBrowser },
        { "https?://%w+.docs.google.com", workBrowser },
        { "https?://%w+.drive.google.com", workBrowser },
        { "https?://%w+.drive.google.com", workBrowser },
        { "https?://%w+.okta.com", workBrowser },
        { "https?://%w+.okta.com", workBrowser },
        { "https?://%w+.teams.microsoft.com", workBrowser },
        { "https?://%w+.youtube.com/watch?v=", videoPlayer },
        { "https?://%w+w2g.tv", videoCallBrowser },
        { "https?://app.strongdm.com", workBrowser },
        { "https?://atlassian.net", workBrowser },
        { "https?://docs.google.com", workBrowser },
        { "https?://drive.google.com", workBrowser },
        { "https?://drive.google.com", workBrowser },
        { "https?://meet.google.com", videoCallBrowser },
        { "https?://okta.com", workBrowser },
        { "https?://teams.microsoft.com", workBrowser },
        { "https?://w2g.tv", workBrowser },
        { "https?://www.youtube.com/watch?v=", videoPlayer },
        { "https?://youtu.be/", videoPlayer },
        { "https://captive.apple.com/", safari },
    }

    _log(debug.getinfo(1, "S").short_src:gsub(".*/", "") .. " loaded in " .. (os.clock() - initStart) .. " seconds.")
end

return urls
