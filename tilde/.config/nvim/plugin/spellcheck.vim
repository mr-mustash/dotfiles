" Check to see if g:isprose is set by `pking#plugins#prose#prose()`.
if exists('g:isprose')
    set spelloptions-=noplainbuffer
else
    set spelloptions+=noplainbuffer
endif

set spell
