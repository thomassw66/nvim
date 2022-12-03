local file = require("user.utils.file")
local dap = require("dap")

dap.defaults.fallback.terminal_win_cmd = "10split new"

dap.configurations.cpp = {
  {
    name = "C++ Debug And Run",
    type = "cppdbg",
    request = "launch",
    program = function()
      -- First, check if exists CMakeLists.txt
      local cwd = vim.fn.getcwd()
      if file.exists(cwd, "CMakeLists.txt") then
        -- Then invoke cmake commands
        -- Then ask user to provide execute file
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      elseif file.exists(cwd, "Makefile") or file.exists(cwd, "makefile") then
        -- check for unix makefiles
        local cmd = "!make all"
        vim.cmd(cmd)
        return "main"
      else
        local fileName = vim.fn.expand("%:t:r")
        -- create this directory
        os.execute("mkdir -p " .. "bin")
        local cmd = "!g++ -g % -o bin/" .. fileName
        -- First, compile it
        vim.cmd(cmd)
        -- Then, return it
        return "${fileDirname}/bin/" .. fileName
      end
    end,
    -- miMode = "",
    cwd = "${fileDirname}",
    stopOnEntry = false,
    runInTerminal = true,
    console = "integratedTerminal",
    setupCommands = {
      {
      text = "-enable-pretty-printing",
      description = "enable pretty printing",
      ignoreFailures = false,
      }
    }
    --    pythonpath = "/usr/bin/python",
  },
}
