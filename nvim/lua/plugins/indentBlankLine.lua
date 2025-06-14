return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = function()
    -- Definisi satu warna saja
    local hl = vim.api.nvim_set_hl
    hl(0, "RainbowCyan", { fg = "#56B6C2" })

    return {
      indent = {
        char = "╎",
        tab_char = "╎",
        smart_indent_cap = true,
      },
      whitespace = {
        remove_blankline_trail = true,
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        injected_languages = true,
        highlight = {
          "RainbowCyan", -- hanya satu warna dipakai di semua indent scope
        },
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "lazy",
          "NvimTree",
          "Trouble",
          "markdown",
          "lspinfo",
          "packer",
        },
        buftypes = { "terminal", "nofile", "quickfix" },
      },
    }
  end,
}

