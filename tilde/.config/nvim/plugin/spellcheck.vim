" Check to see if g:isprose is set by prose.vim
if exists('g:isprose')
    set spelloptions-=noplainbuffer
else
    set spelloptions+=noplainbuffer,camel
endif

set spell
