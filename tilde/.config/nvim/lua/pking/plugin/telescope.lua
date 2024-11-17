return {
    {
        'nvim-telescope/telescope.nvim',
        keys = {
            { "<leader>p",  "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>rg", "<cmd>Telescope live_grep<cr>", desc = "Grep files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep files" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Search help tags" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Find recent files" },
            { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep current string" },
        },
        cmd = "Telescope",
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    path_display = { "truncate " },
                    mappings = {
                        i = {
                            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                            ["<C-j>"] = actions.move_selection_next, -- move to next result
                            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<esc>"] = actions.close
                        },
                    },
                },
            })

            telescope.load_extension("fzf")

            -- set keymaps
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>p', builtin.find_files, {})
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>rg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>b', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})
            vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
            vim.keymap.set('n', '<leader>fl', builtin.highlights, {})
        end,
    }
}
