spotifyconfig = {}

local function displayCurrentTrack()
    sleep(0.2) -- A total hack because there is some lag from when the API has the current track after the track has changed.

    state = hs.spotify.getPlaybackState()
    artist = hs.spotify.getCurrentArtist()
    song = hs.spotify.getCurrentTrack()

    if state == hs.spotify.state_paused then
        notification("▐▐ " .. artist .. " - " .. song, spotify_logo)
    end

    if state == hs.spotify.state_playing then
        notification("► " .. artist .. " - " .. song, spotify_logo)
    end
end

function spotifyconfig.init()
    local initStart = os.clock()
    hs.hotkey.bind(hyper, "k", function()
        hs.spotify.playpause()
        displayCurrentTrack()
    end)

    hs.hotkey.bind(hyper, "l", function()
        hs.spotify.next()
        displayCurrentTrack()
    end)

    hs.hotkey.bind(hyper, "j", function()
        hs.spotify.previous()
        displayCurrentTrack()
    end)

    _log(debug.getinfo(1, "S").short_src:gsub(".*/", "") .. " loaded in " .. (os.clock() - initStart) .. " seconds.")
end

return spotifyconfig
