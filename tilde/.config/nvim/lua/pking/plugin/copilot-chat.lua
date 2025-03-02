local system_prompt = [[
You are an advanced AI assistant designed to assist users with code-related tasks. Your primary goal is to provide accurate, efficient, and well-structured responses while ensuring clarity and best practices. Follow these guidelines when responding:

1) Be Concise Yet Informative
* Provide clear and direct answers focused on code-related topics
* Include brief explanations before presenting code only when necessary
* For non-coding questions, provide a brief response and suggest relevant documentation or resources

2) Stay Within Scope
* Focus exclusively on coding and development-related topics
* If a question is outside the scope of programming or development, politely redirect to appropriate resources
* Only engage in broader discussions when explicitly requested by the user

3) Code Formatting and Style
* Always enclose code within properly formatted markdown blocks with language specification
* Follow language-specific conventions and best practices
* Include error handling where appropriate

4) Adapt to User Intent
* If a request is unclear or ambiguous, ask for clarification instead of making assumptions
* When multiple solutions exist, present the most relevant approach first
* Adjust the technical depth of responses based on the user's apparent expertise level

5) Response Structure
* Start with the most direct solution to the problem
* If multiple approaches exist, present the recommended solution first
* Include documentation references where relevant

Remember: Keep responses focused on code and development while being responsive to the user's needs and expertise level.]]

local function get_encoded_path(filepath)
    return filepath:gsub("^%s*(.-)%s*$", "%1") -- trim
        :gsub("^~", "~=+")          -- encode home dir
        :gsub("/", "=+")            -- encode path separators
end

return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        keys = {
            -- Automatically load the chat history
            { "<leader>co", function()
                -- Get the current buffer's file path
                local current_file = vim.fn.expand('%:p')
                if current_file and current_file ~= "" then
                    -- Convert the path to vim-style encoding (replace / with =+)
                    local encoded_path = get_encoded_path(current_file)

                    -- Load the chat history for this file
                    vim.cmd(string.format("CopilotChatLoad %s", vim.fn.fnameescape(encoded_path)))
                end

                -- Create a new chat buffer
                vim.cmd("CopilotChatOpen")
            end, desc = "Open Copilot Chat" },
            { "<leader>cot", " <cmd>CopilotChatToggle<cr>", desc = "Toggle Chat" },
            { "<leader>coe",  "<cmd>CopilotChatExplain<cr>", desc = "Explain Code" },
            { "<leader>cof",  "<cmd>CopilotChatFix<cr>", desc = "Fix Code" },
            { "<leader>cor",  "<cmd>CopilotChatReset<cr>", desc = "Reset Chat" },
        },
        cmd = "CopilotChat",
        build = "make tiktoken",
        opts = {
            system_prompt = system_prompt,
            model = "claude-3.5-sonnet",
            context = "buffers",
            sticky = {
                '#buffers',
            },
            mappings = {
                submit_prompt = {
                    normal = '<C-CR>',
                    insert = '<C-CR>'
                },
                show_diff = {
                    full_diff = true
                },
                close = {
                    normal = 'q',
                    insert = '<C-c>'
                },
                toggle = {
                    normal = '<leader>cot',
                },
            },
            code_actions = {
                enabled = true,
                show_action_hints = true
            },
            question_header = " User ",
            answer_header = " Copilot ",
            error_header = "󰬅 Error ",
            auto_follow_cursor = true,
            clear_chat_on_close = false,
            debug = false,
            highlight_selection = false,
            window = {
                border = 'rounded',
                width = 0.4,
                relative = 'editor',
            },
            show_help = true,
        },
        config = function(_, opts)
            require("CopilotChat").setup(opts)

            -- Start in insert mode
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "copilot-chat",
                callback = function()
                    if vim.bo.filetype == "copilot-chat" then
                        vim.opt_local.number = false
                        vim.opt_local.relativenumber = false
                        vim.opt_local.signcolumn = "no"

                        -- Make sure this runs after any other FileType autocmds
                        vim.schedule(function()
                            vim.cmd("startinsert!")
                        end)
                    end
                end,
            })

            vim.api.nvim_set_hl(0, "CopilotChatHeader", { fg = "#268BD2" })
            vim.api.nvim_set_hl(0, "CopilotChatSeparator", { fg = "#6C71C4" })


            local skip_filetypes = {
                [""] = true,
                ["copilot-chat"] = true,
                ["TelescopePrompt"] = true,
                ["help"] = true,
                ["qf"] = true,
                ["terminal"] = true,
                ["prompt"] = true,
                ["netrw"] = true,
                ["commit"] = true,
                ["cvs"] = true,
                ["git"] = true,
                ["gitcommit"] = true,
                ["gitrebase"] = true,
                ["gitsendmail"] = true,
                ["hgcommit"] = true,
                ["man"] = true,
                ["markdown"] = true,
                ["md"] = true,
                ["mkd"] = true,
                ["svn"] = true,
                ["tex"] = true,
                ["text"] = true,
                ["yaml"] = true,
            }

            local skip_buftypes = {
                ["terminal"] = true,
                ["prompt"] = true,
                ["quickfix"] = true,
                ["nofile"] = true,
                ["help"] = true,
                ["acwrite"] = true,
                ["nowrite"] = true,
            }

            -- Automatically save the chat history for each file
            local chat_augroup = vim.api.nvim_create_augroup("CopilotChatSave", { clear = true })
            vim.api.nvim_create_autocmd({"BufWritePre", "VimLeavePre"}, {
                group = chat_augroup,
                callback = function()
                    local bufnr = vim.api.nvim_get_current_buf()
                    -- Skip special buffers and copilot-chat itself
                    if skip_buftypes[vim.bo[bufnr].buftype] or skip_filetypes[vim.bo[bufnr].filetype] then
                        return
                    end

                    local current_file = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ':p')
                    if current_file and current_file ~= "" then
                        local encoded_path = get_encoded_path(current_file)
                        vim.cmd(string.format("CopilotChatSave %s", vim.fn.fnameescape(encoded_path)))
                    end
                end,
            })

        end,
    },
}
