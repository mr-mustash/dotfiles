--return { { "github/copilot.vim", build = ":Copilot auth", cmd = "Copilot",
--event = "InsertEnter", config = function () vim.cmd([[ imap
    --<silent><script><expr> <C-k> copilot#Accept("\<CR>") let
    --g:copilot_no_tab_map = v:true
--
--            " Copilot suggestions
--            inoremap <C-p>  <Esc>:Copilot<CR>i " List all sugestions
--            imap <silent><script><expr> <C-l> <Plug>(copilot-next)
--            imap <silent><script><expr> <C-h> <Plug>(copilot-previous)
--
--            " Disable copilot when working on text files
--            let g:copilot_filetypes = {
--                \ 'markdown':     v:false,
--                \ 'mkd':          v:false,
--                \ 'md':           v:false,
--                \ 'tex':          v:false,
--                \ 'text':         v:false,
--                \ 'git':          v:false,
--                \ 'gitsendemail': v:false,
--                \ 'gitcommit':    v:false,
--                \ '*commit*':     v:false,
--                \ '*COMMIT*':     v:false,
--                \ }
--
--                let g:copilot_enabled = 1
--            ]])
--        end,
--    }
--}

--[[
return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function ()
            require('copilot').setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
                filetypes = {
                    [""] = false,
                    commit = false,
                    cvs = false,
                    git = false,
                    gitcommit = false,
                    gitrebase = false,
                    gitsendmail = false,
                    help = false,
                    hgcommit = false,
                    man = false,
                    markdown = false,
                    md = false,
                    mkd = false,
                    svn = false,
                    tex = false,
                    text = false,
                    yaml = false,
                },
            })
        end
    }
 }
]]--

return {}
