local is_unix = vim.fn.has("unix") == 1
local is_win32 = vim.fn.has("win32") == 1
local is_wsl = vim.fn.has("wsl") == 1

local extension_path
local cmd


if is_wsl then
  extension_path = vim.env.HOME .. "/.vscode-server/extensions/ms-vscode.cpptools-1.12.4-linux-x64/"
  cmd = extension_path .. "debugAdapters/bin/OpenDebugAD7"
end

if not cmd then
  vim.notify("currently cppdbg dap is only configured for wsl linux")
  return
end

local dap = require("dap")
dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command = cmd,
}
