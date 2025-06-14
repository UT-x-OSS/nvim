return{
  "theHamsta/nvim-dap-virtual-text",
  event = "VeryLazy",  -- Trigger the plugin on a specific event (e.g., after Neovim has loaded)
  config = function()
    require('nvim-dap-virtual-text').setup({
      enabled = true,                     -- Enable the plugin
      highlight_changed_variables = true, -- Highlight changed variables
      dynamic = true,                     -- Update virtual text dynamically
      virtual_text = {
        prefix = ">>",                   -- Prefix for variable values
        source = "always",               -- Show the source of the variable
      },
    })
  end,
}

