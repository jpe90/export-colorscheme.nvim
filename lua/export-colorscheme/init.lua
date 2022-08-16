local M = {}
local util = require"export-colorscheme.util"

-- ============================================================================
--                                Templates

local kak = require"export-colorscheme/templates/kakoune"
local vis = require"export-colorscheme/templates/vis"
local clp = require"export-colorscheme/templates/clp"
local templates = {
	kak,
	vis,
	clp
}

M.add_template = function(template)
	table.insert(templates,template)
end

M.templates = templates

local function get_selected_template(tmp_name)
	for _, template in pairs(templates) do
		if(template.name == tmp_name) then return template end
	end
end

-- ============================================================================
--                                Colors

-- These are the vim color groups that satisfy the union of the requirements
-- of all templates
local color_names = {
	"Normal",
	"Comment",
	"Constant",
	"ErrorMsg",
	"WarningMsg",
	"Function",
	"Keyword",
	"Label",
	"Number", -- numeric literal
	"Operator",
	"String",
	"PreProc", -- preprocessor
	"Tag",
	"Type",
	"Whitespace",
	"Identifier",
	"LineNr",
	"CursorLineNr",
	"Cursor",
	"Search", -- cursor primary candidate
	"IncSearch", -- cursor primary candidate
	"CursorLine",
	"ColorColumn",
	"Visual", -- fix
	"StatusLineNC",
	"StatusLine",
	"Pmenu",
	-- EOF == LineNr
}

-- ============================================================================
--                                Functions

local function get_highlight_colors()
	local highlight_colors = {}
	for _, color_name in pairs(color_names) do
		highlight_colors[color_name] =
		vim.api.nvim_get_hl_by_name(color_name, true)
	end
	return highlight_colors
end

local function write_to_file(filename, str)
	local file = io.open(filename,"w")
	io.output(file)
	io.write(str)
	io.close(file)
end

-- ============================================================================
--                                Driver

M.run = function(opts)
	if vim.version().minor < 7 then
		vim.notify_once("ecs error: neovim >= 0.7 required",
		vim.log.levels.ERROR)
		return
	end

	if vim.g.colors_name == nil then
		vim.notify_once("ecs error: a color theme has not been set",
		vim.log.levels.ERROR)
		return
	end

	local export_ft = opts.fargs[1]
	local template = get_selected_template(export_ft)
	local filename = vim.g.colors_name .. '.' .. template.extension
	local highlight_colors = get_highlight_colors()
	local ft_intp_tbl = template.make_interpolation_table(highlight_colors)
	local subbed = util.interp(template.content,ft_intp_tbl)
	write_to_file(filename,subbed)
end

return M
