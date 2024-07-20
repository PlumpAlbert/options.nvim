local M = {}

local defaultOpts = {
	theme = "retrobox",
	useTabs = true,
	indent = 4,
	rulers = { 80 },
	wrap = false,
	lineNumbers = "both",
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
	local opts = require("neoconf").get("options", defaultOpts)

	vim.cmd("colorscheme " .. opts.theme)
	vim.o.number = enableLineNumbers(opts.lineNumbers)
	vim.o.relativenumber = enableRelativeLineNumbers(opts.lineNumbers)
	vim.o.wrap = opts.wrap
	vim.o.expandtab = not opts.useTabs
	vim.o.tabstop = opts.indent

	vim.opt.colorcolumn = opts.rulers
end

function M.setup(opts)
	opts = vim.tbl_extend("force", defaultOpts, opts or {})

	require("neoconf.plugins").register({
		name = "options.nvim",
		on_schema = function(schema)
			schema:set("options", {
				type = "object",
				properties = {
					theme = {
						description = "Set NeoVim colorscheme",
						type = "string",
						enum = vim.fn.getcompletion("", "color"),
					},
					indent = {
						description = "Width of the indent",
						type = "integer",
						minimum = 2,
					},
					useTabs = {
						description = "Use tab character for indentation",
						type = "boolean",
					},
					rulers = {
						description = "Code ruler markers",
						type = "array",
						items = {
							type = "number",
						},
					},
					wrap = {
						description = "Enable line wrapping",
						type = "boolean",
					},
					lineNumbers = {
						description = "Display line numbering",
						anyOf = {
							{
								type = "string",
								enum = {
									"both",
									"relativeOnly",
									"normalOnly",
									"off",
								},
							},
							{ type = "boolean" },
						},
					},
				},
			})
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
