
return {
  "echasnovski/mini.hipatterns",
  event = { "BufReadPre", "BufNewFile" },
  version = "*",
  config = function()
    local hipatterns = require("mini.hipatterns")
    hipatterns.setup({
      highlighters = {
        -- ✨ Auto highlight hex colors like #ff0000
        hex_color = hipatterns.gen_highlighter.hex_color(),

        -- ✅ TODO/FIXME/NOTE highlighting with color hints
        todo = {
          pattern = "%f[%w]()TODO()%f[%W]",
          group = "DiagnosticHint",
        },
        fixme = {
          pattern = "%f[%w]()FIXME()%f[%W]",
          group = "DiagnosticError",
        },
        note = {
          pattern = "%f[%w]()NOTE()%f[%W]",
          group = "DiagnosticInfo",
        },
      },
    })
  end,
}

