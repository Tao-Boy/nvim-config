return {
  "mfussenegger/nvim-dap",
  ft = "cpp",
  dependencies = {
    "rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text", "nvim-neotest/nvim-nio"
  },
  config = function()
    local dap = require('dap')
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
    vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo" })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "Constant" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "" })

    dap.adapters.codelldb = {
      type = "executable",
      command = "/root/.local/share/nvim/mason/packages/codelldb/codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
      detached = false,
    }
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
    local dapui = require "dapui"
    dapui.setup {}

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open {}
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close {}
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close {}
    end
  end,
  keys = {
    {
      "<F8>",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Debug: Toggle breakpoint",
    },
    {
      "<F9>",
      function()
        require("dap").continue()
      end,
      desc = "Debug: Continue",
    },
    {
      "<F10>",
      function()
        require("dap").step_into()
      end,
      desc = "Debug: Step into",
    },
    {
      "<F11>",
      function()
        require("dap").step_over()
      end,
      desc = "Debug: Step over",
    },
    {
      "<F12>",
      function()
        require("dap").step_out()
      end,
      desc = "Debug: Step out",
    },

    {
      "<leader>db",
      function()
        require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
      end,
      desc = "Set breakpoint",
    },
    {
      "<leader>dp",
      function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
      end,
      desc = "Set log point",
    },
    {
      "<leader>dr",
      function()
        require("dap").repl.toggle()
      end,
      desc = "Toggle REPL",
    },
    {
      "<leader>dl",
      function()
        require("dap").run_last()
      end,
      desc = "Run last",
    },
  },
}
