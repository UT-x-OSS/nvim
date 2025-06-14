
return {
  "stevearc/dressing.nvim",
  config = function()
    local ok, dressing = pcall(require, "dressing")
    if not ok then
      vim.notify("dressing.nvim tidak ditemukan!", vim.log.levels.WARN)
      return
    end

    dressing.setup({
      input = {
        enabled = true,                 -- Aktifkan UI baru untuk input (misal :rename LSP)
        default_prompt = "➤ ",          -- Prompt input yang keren
        insert_only = false,            -- Bisa dipakai di mode normal juga
        win_options = {
          winblend = 10,                -- Transparansi window, biar elegan
          winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
        -- Callback ketika input selesai
        on_confirm = function(input)
          -- Misal kamu mau log inputnya atau lain-lain
          -- print("Input diterima: " .. input)
        end,
      },
      select = {
        enabled = true,                 -- Aktifkan UI baru untuk select list
        backend = { "fzf_lua", "telescope", "builtin" }, -- Prioritas backend, fallback bertahap
        trim_prompt = true,             -- Potong spasi di prompt select
        builtin = {
          border = "rounded",
          max_width = 80,
          max_height = 15,
          min_width = 40,
          min_height = 5,
          mappings = {
            ["<Esc>"] = "cancel",       -- Tombol cancel bawaan
            ["<CR>"] = "confirm",
          },
        },
      },
      -- Opsi tambahan untuk message UI, misal untuk error atau info popup
      message = {
        enabled = true,
        min_height = 1,
        max_height = 20,
        timeout = 3000,
      },
    })
  end,
}

