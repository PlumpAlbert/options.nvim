local M = {}

M.init = function()
	require("neoconf.plugins").register({
		name = "options.nvim",
		on_schema = function(schema)
			schema:set("formatters", {
				type = "object",
				description = "Map of ft/formatters (conform.nvim style)",
				additionalProperties = {
					type = "array",
					description = "List of formatters for specified file type",
					items = { type = "string" },
				},
			})
		end,
	})
end

M.load = function()
	local formatters_by_ft = require("neoconf").get("formatters", {})

	local ok, conform = pcall(require, "conform")
	if not ok then
		vim.notify("conform.nvim is not installed", vim.log.levels.WARN)
		return
	end

	conform.formatters_by_ft =
		vim.tbl_deep_extend("force", conform.formatters_by_ft, formatters_by_ft)
end

return M
