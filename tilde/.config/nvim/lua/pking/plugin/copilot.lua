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
