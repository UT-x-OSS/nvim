
return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("diffview").setup({
      enhanced_diff_hl = true, -- Highlight lebih baik
      view = {
        merge_tool = {
          layout = "diff3_mixed", -- Pilihan lain: 'diff3_horizontal'
          disable_diagnostics = true, -- Nonaktifkan LSP diagnostic saat merge
        },
        default = {
          layout = "diff2_horizontal",
        },
      },
      file_panel = {
        win_config = {
          position = "left",
          width = 35,
        },
      },
      keymaps = {
        view = {
          ["<leader>q"] = "<Cmd>DiffviewClose<CR>", -- Keymap cepat untuk keluar
        },
      },
    })
  end,
}

