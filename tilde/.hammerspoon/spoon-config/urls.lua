urls = {}

function urls.init()
    spoon.URLDispatcher:start()

    local workBrowser = appID(secrets.urls.workBrowser)
    local personalBrowser = appID(secrets.urls.personalBrowser)
    --local videoPlayer = appID(secrets.urls.videoPlayer)
    --local vpn = appID(secrets.urls.vpn)
    --local meetings = appID(secrets.urls.meetings)

    spoon.URLDispatcher.default_handler = personalBrowser
    spoon.URLDispatcher.decode_slack_redir_urls = true
    spoon.URLDispatcher.set_system_handler = true

    spoon.URLDispatcher.url_patterns = {
        --{"file:///", workBrowser}, {"globalprotectcallback:", vpn},
        {"https?://%w+.app.datadoghq.com", workBrowser},
        {"https?://%w+.atlassian.net", workBrowser},
        {"https?://%w+.corp.onepeloton.com", workBrowser},
        {"https?://%w+.datadoghq.com", workBrowser},
        {"https?://%w+.docs.google.com", workBrowser},
        {"https?://%w+.drive.google.com", workBrowser},
        {"https?://%w+.drive.google.com", workBrowser},
        {"https?://%w+.github.com/pelotoncycle", workBrowser},
        {"https?://%w+.okta.com", workBrowser},
        {"https?://%w+.okta.com", workBrowser},
        {"https?://%w+.onepeloton.com", workBrowser},
        {"https?://%w+.team.onepeloton.com", workBrowser},
        {"https?://%w+.teams.microsoft.com", workBrowser},
        --{"https?://%w+.youtube.com/watch?v=", videoPlayer},
        --{"https?://%w+.zoom.us/j/", meetings},
        {"https?://%w+w2g.tv", workBrowser},
        {"https?://.+.pelotime.com", workBrowser},
        {"https?://app.strongdm.com", workBrowser},
        {"https?://atlassian.net", workBrowser},
        {"https?://corp.onepeloton.com", workBrowser},
        {"https?://docs.google.com", workBrowser},
        {"https?://drive.google.com", workBrowser},
        {"https?://drive.google.com", workBrowser},
        {"https?://github.com/pelotoncycle", workBrowser},
        {"https?://okta.com", workBrowser},
        {"https?://onepeloton.com", workBrowser},
        {"https?://onepeloton.gpcloudservice.com/", workBrowser},
        {"https?://team.onepeloton.com", workBrowser},
        {"https?://teams.microsoft.com", workBrowser},
        {"https?://w2g.tv", workBrowser},
        {"https?://www.youtube.com/watch?v=", videoPlayer},
        --{"https?://youtu.be/", videoPlayer}, {"https?://zoom.us/j/", meetings}
    }

    _log("URL Dispatcher config loaded.")
end

return urls
