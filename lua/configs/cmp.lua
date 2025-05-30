return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "petertriho/cmp-git",
      "ray-x/cmp-treesitter",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-copilot",

      {
        "supermaven-inc/supermaven-nvim",
        opts = {},
      },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              local entry = cmp.get_selected_entry()
              if entry and entry.source.name == "supermaven" then
                cmp.confirm({ select = true })
              else
                cmp.select_next_item()
              end
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
          ["<CR>"] = function(fallback)
            if cmp.visible() then
              local entry = cmp.get_selected_entry()
              if entry and entry.source.name ~= "supermaven" then
                cmp.confirm({ select = true })
              else
                fallback()
              end
            else
              fallback()
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end,
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        window = {
          completion = cmp.config.window.bordered({ border = "rounded" }),
          documentation = cmp.config.window.bordered({ border = "rounded" }),
        },
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = function(entry, vim_item)
            vim_item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              path = "[Path]",
              copilot = "[Copilot]",
              spell = "[Spell]",
              git = "[Git]",
              treesitter = "[TS]",
              calc = "[Calc]",
              emoji = "[Emoji]",
              supermaven = "[SM]",
            })[entry.source.name]
            return vim_item
          end,
        },
        experimental = {
          ghost_text = true,
        },
        sources = cmp.config.sources({
          { name = "supermaven" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "calc" },
          { name = "emoji" },
          { name = "nvim_lua" },
          { name = "treesitter" },
          { name = "git" },
          { name = "spell" },
          { name = "copilot" },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
}
