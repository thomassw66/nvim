local ok, dap = pcall(require, "dap")
if not ok then
	return
end

vim.notify("setting up dapui!")

require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")

--dap.adapters.codelldb = function(callback, _)
--	require("terminal").launch_terminal("codelldb", true, function()
--		vim.api.nvim_buf_set_name(0, "codelldb server")
--		vim.defer_fn(function()
--			callback({ type = "server", host = "127.0.0.1", port = 13000 })
--		end, 1500)
--	end)
--end

local port = 13000

dap.adapters.codelldb = {
	type = "server",
	host = "127.0.0.1",
	port = "${port}",
	executable = {
		command = "/Users/thomaswheeler/.vscode/extensions/vadimcn.vscode-lldb-1.7.4/adapter/codelldb",
		args = { "--port", "${port}" },
	},
}

dap.configurations.cpp = {
	{
		type = "codelldb",
		request = "launch",
		cwd = "${workspaceFolder}",
		console = "integratedTerminal",
		stopOnEntry = false,
		program = function()
			return vim.fn.input("executable: ", vim.fn.getcwd() .. "/", "file")
		end,
	},
}
dap.configurations.c = dap.configurations.cpp

local function start_session()
	dapui.open()
end

local function terminate_session()
	dapui.close()
end

dap.listeners.after.event_initialized["autodap_key"] = start_session

dap.listeners.before.event_terminated["autodap_key"] = terminate_session

dap.listeners.before.event_exited["autodap_key"] = terminate_session
