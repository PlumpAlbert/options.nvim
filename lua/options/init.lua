local M = {}

M.options = {
	theme = "retrobox",
	useTabs = true,
	indent = 4,
	rulers = { 80 },
	wrap = false,
	lineNumbers = "both",
	shell = nil,
	transparent = false,
}

--- @param val boolean|"both"|"relativeOnly"|"normalOnly"|"off"
local function enableLineNumbers(val)
	if val == false or val == "off" or val == "relativeOnly" then
		return false
	end

	return true
end

--- @param val boolean|"both"|"relativeOnly"|"normalOnly"|"off"
local function enableRelativeLineNumbers(val)
	if val == "relativeOnly" or val == "both" then
		return true
	end

	return false
end

function M.apply()
	local opts = require("neoconf").get("options", M.options)

	vim.cmd("colorscheme " .. opts.theme)
	vim.o.number = enableLineNumbers(opts.lineNumbers)
	vim.o.relativenumber = enableRelativeLineNumbers(opts.lineNumbers)
	vim.o.wrap = opts.wrap
	vim.o.expandtab = not opts.useTabs
	vim.o.tabstop = opts.indent

	vim.opt.colorcolumn = opts.rulers

	if opts.shell ~= nil then
		vim.opt.shell = opts.shell
	end

	local success, _ = pcall(require, "transparent")
	if not success then
		vim.notify("transparent is not available", vim.log.levels.INFO)
		return
	end

	if opts.transparent then
		vim.cmd("TransparentEnable")
	else
		vim.cmd("TransparentDisable")
	end
end

function M.setup(opts)
	M.options = vim.tbl_extend("force", M.options, opts or {})

	require("neoconf.plugins").register({
		name = "options.nvim",
		on_schema = function(schema)
			schema:set("options", require("options.schema"))
		end,
		on_update = function()
			vim.notify("Updated NeoVim configuration", vim.log.levels.INFO)
			M.apply()
		end,
		setup = function()
			M.apply()
		end,
	})
end

return M
