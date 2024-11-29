return {
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
		shell = {
			type = { "string", "null" },
			description = "Name of the shell to use for `!` and `:!` commands",
		},
		transparent = {
			type = "boolean",
			description = "Force transparent background",
		},
	},
}
