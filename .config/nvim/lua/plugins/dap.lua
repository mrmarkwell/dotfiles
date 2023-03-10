return {
  "mfussenegger/nvim-dap",
  dependencies = { "rcarriga/nvim-dap-ui" },
  lazy = true,
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Set up nvim-dap and nvim-dap-ui.
    dap.adapters.python = {
      type = "server",
      port = 5678,
      host = "localhost",
    }
    dap.configurations.python = {
      {
        type = "python",
        request = "attach",
        name = "Attach to debugpy.",
      },
    }
    dapui.setup()

    -- Open/close DAP UI automatically.
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
}
