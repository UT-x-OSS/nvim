return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Header default (bisa kamu ganti nanti)
    dashboard.section.header.val = {
      "███╗   ██╗██╗   ██╗██╗███╗   ███╗",
      "████╗  ██║██║   ██║██║████╗ ████║",
      "██╔██╗ ██║██║   ██║██║██╔████╔██║",
      "██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
      "██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
      "╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
    }

    -- Tombol default
    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
      dashboard.button("f", "󰈞  Find file", ":Telescope find_files<CR>"),
      dashboard.button("r", "󰊄  Recent files", ":Telescope oldfiles<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    -- Footer default
    local fortune = vim.fn.systemlist("fortune -s")
    if vim.tbl_isempty(fortune) then fortune = { "Happy coding! 💻" } end
    dashboard.section.footer.val = fortune
    dashboard.section.footer.opts.hl = "DashboardFooter"

    -- Konfigurasi layout
    local config = dashboard.config
    config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    config.opts.noautocmd = true
    alpha.setup(config)
  end,
  event = "VimEnter",
}


