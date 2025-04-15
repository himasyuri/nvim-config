local M = {}
local map = vim.keymap.set

-- DAP keymaps
local function set_keymaps()
  local dap = require "dap"
  local widgets = require "dap.ui.widgets"

  map("n", "<F5>", dap.continue)
  map("n", "<F10>", dap.step_over)
  map("n", "<F11>", dap.step_into)
  map("n", "<F12>", dap.step_out)
  map("n", "<Leader>b", dap.toggle_breakpoint)
  map("n", "<Leader>B", dap.set_breakpoint)
  map("n", "<Leader>lp", function()
    dap.set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
  end)
  map("n", "<Leader>dr", dap.repl.open)
  map("n", "<Leader>dl", dap.run_last)
  map({ "n", "v" }, "<Leader>dh", widgets.hover)
  map({ "n", "v" }, "<Leader>dp", widgets.preview)
  map("n", "<Leader>df", function()
    widgets.centered_float(widgets.frames)
  end)
  map("n", "<Leader>ds", function()
    widgets.centered_float(widgets.scopes)
  end)
  map("n", "<Leader>du", function()
    require("dapui").toggle()
  end)
end

local function get_netcoredbg_path()
  local mason_registry = require "mason-registry"
  local debugger = mason_registry.get_package "netcoredbg"
  return debugger:get_install_path() .. "/netcoredbg"
end

M.setup = function()
  local dap = require "dap"
  local dapui = require("dapui")

  dapui.setup()  -- Ensure dapui is set up properly

  -- C# / .NET (netcoredbg)
  dap.adapters.coreclr = {
    type = "executable",
    command = get_netcoredbg_path(),
    args = { "--interpreter=vscode" },
  }

  dap.configurations.cs = {
    {
      type = "coreclr",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
        return vim.fn.input(
          "Path to dll: ",
          vim.fn.getcwd() .. "/bin/Debug/net6.0/",
          "file"
        )
      end,
    },
  }

  -- Go (Delve)
  dap.adapters.delve = {
    type = "server",
    port = 2345,
    executable = {
      command = "dlv",
      args = { "dap", "-l", "127.0.0.1:2345" },
    },
  }

  dap.configurations.go = {
    {
      type = "delve",
      name = "Debug",
      request = "launch",
      program = function()
        return vim.fn.input("Path to file: ", vim.fn.getcwd(), "file")
      end,
    },
    {
      type = "delve",
      name = "Debug test",
      request = "launch",
      mode = "test",
      program = function()
        return vim.fn.input("Path to test file: ", vim.fn.getcwd(), "file")
      end,
    },
    {
      type = "delve",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = function()
        return vim.fn.input("Path to go.mod file: ", vim.fn.getcwd(), "file")
      end,
    },
  }

  set_keymaps()
end

return M
