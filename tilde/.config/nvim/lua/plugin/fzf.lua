return {
    {
      "ibhagwan/fzf-lua",
      keys = {
          { "<leader>p", ":FzfLua files<cr>", desc = "FZF Files" },
          { "<leader>ff", ":FzfLua files<cr>", desc = "FZF Files" },
          { "<leader>fh", ":FzfLua help_tags<cr>", desc = "FZF Helptags" },
          { "<leader>fh", ":FzfLua help_tags<cr>", desc = "FZF Helptags" },
          { "<leader>rg", ":FzfLua live_grep<cr>", desc = "FZF Grep" },
      },
      config = function()
        require("fzf-lua").setup({})
      end
    }
}
