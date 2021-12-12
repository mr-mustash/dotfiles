spotifyconfig = {}

local function displayCurrentTrack()
    state  = hs.spotify.getPlaybackState()
    artist = hs.spotify.getCurrentArtist()
    song  = hs.spotify.getCurrentTrack()

    if state == hs.spotify.state_paused
    then
        notification("▐▐ " .. artist .. " - " .. song, spotify_logo)
    end

    if state == hs.spotify.state_playing
    then
        notification("► " .. artist .. " - " .. song, spotify_logo)
    end

end

function spotifyconfig.init()
    hs.hotkey.bind(hyper,"k", function()
        hs.spotify.playpause()
        displayCurrentTrack()
    end)

    hs.hotkey.bind(hyper,"l", function()
        hs.spotify.next()
        displayCurrentTrack()
    end)

    hs.hotkey.bind(hyper,"j", function()
        hs.spotify.previous()
        displayCurrentTrack()
    end)
end

return spotifyconfig
