require("dap-python").setup("python", {})


local dap = require("dap")

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = "python"; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = "launch";
    name = "Launch file";
    program = "${file}"; -- This configuration will launch the current file if used.

    pythonpath = function()

      return "/usr/bin/python"
    end;
  },
}
