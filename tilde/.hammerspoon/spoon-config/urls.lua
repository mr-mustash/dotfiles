urls = {}

function urls.init()
    spoon.URLDispatcher:start()

    local chromeBrowser = appID("/Applications/Google Chrome.app")
    local firefoxBrowser = appID("/Applications/Firefox Nightly.app")
    local spotify = appID("/Applications/Spotify.app")
    local zoom = appID("/Applications/zoom.us.app")
    local freetube = appID("/Applications/Freetube.app")

    defaultBrowser = firefoxBrowser
    workBrowser = chromeBrowser

    spoon.URLDispatcher.default_handler = defaultBrowser
    spoon.URLDispatcher.decode_slack_redir_urls = true
    spoon.URLDispatcher.set_system_handler = true

    spoon.URLDispatcher.url_patterns = {
        { "https?://zoom.us/j/", zoom },
        { "https?://%w+.zoom.us/j/", zoom },
        { "https?://open.spotify.com", spotify },
        { "https?://www.youtube.com/watch?v=", freetube },
        { "https?://%w+.youtube.com/watch?v=", freetube },
        { "https?://youtu.be/", freetube },
        { "https?://github.com/pelotoncycle/", workBrowser },
        { "https?://%w+.github.com/pelotoncycle/", workBrowser },
        { "https?://atlassian.net//", workBrowser },
        { "https?://%w+.atlassian.net/", workBrowser },
        { "https?://drive.google.com", workBrowser },
        { "https?://%w+.drive.google.com", workBrowser },
        { "https?://docs.google.com", workBrowser },
        { "https?://%w+.docs.google.com", workBrowser },
        { "https?://okta.com", workBrowser },
        { "https?://%w+.okta.com", workBrowser },
        { "https?://%w+.okta.com", workBrowser },
        { "https?://%w+.onepeloton.com", workBrowser },
        { "https?://onepeloton.com", workBrowser },
        { "https?://%w+.corp.onepeloton.com", workBrowser },
        { "https?://corp.onepeloton.com", workBrowser },
        { "https?://app.strongdm.com", workBrowser },
        { "https?://teams.microsoft.com", workBrowser },
        { "https?://%w+.teams.microsoft.com", workBrowser },
        { "https?://%w+.datadoghq.com", workBrowser },
        { "https?://%w+.app.datadoghq.com", workBrowser },
        { "https?://.+.pelotime.com", workBrowser },
        { "file:///Users/patrick.king/Library/Application%20Support/PaloAltoNetworks/GlobalProtect", workBrowser },
        { "https?://onepeloton.gpcloudservice.com/", workBrowser },
    }

    _log("URL Dispatcher config loaded.")
end

return urls
