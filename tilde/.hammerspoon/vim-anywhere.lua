local hammerVimFunc = {}

function hammerVimFunc.init()
    local VimMode = hs.loadSpoon('VimMode')
    local hammerVim = VimMode:new()

    -- Disable for text editing apps
    hammerVim:disableForApp('Code')
    hammerVim:disableForApp('iTerm')
    hammerVim:disableForApp('MacVim')
    hammerVim:disableForApp('Terminal')

    -- Use fallback mode for non-supporting apps
    hammerVim:useFallbackMode('Google Chrome')
    hammerVim:useFallbackMode('Firefox')

    hammerVim:shouldDimScreenInNormalMode(true)

    hammerVim:enableBetaFeature('block_cursor_overlay')
    hammerVim:enterWithSequence('jk')
end

return hammerVimFunc
