local M = {}
local util = require"export-colorscheme.util"
M.name = "clp"
M.extension = "lua"
M.content = [[
local M = {}
M.term = "truecolor"
M.theme = {
	-- set default to red in hex
	['default'] = ~<Normal>,
	['nothing'] = '',
	['class'] = ~<Type>,
	['comment'] = ~<Comment>,
	['constant'] = ~<Constant>,
	['error'] = ~<ErrorMsg>,
	['function'] = ~<Function>,
	['keyword'] = ~<Keyword>,
	['label'] = ~<Label>,
	['number'] = ~<Number>,
	['operator'] = ~<Operator>,
	['regex'] = ~<Number>,
	['string'] = ~<String>,
	['preprocessor'] = ~<PreProc>,
	['tag'] = ~<Tag>,
	['type'] = ~<Type>,
	['variable'] = ~<Identifier>,
	['whitespace'] = '',
	['embedded'] = ~<String>,
	['identifier'] = ~<Identifier>,
}
return M
]]

local function formatter(tbl)
	for attr, val in pairs(tbl) do
		if attr == "foreground" then
			return "\"#" .. util.rgb_to_hex(val) .. "\""
		end
	end
end

M.make_interpolation_table = function(hl_groups)
	local result = {}
	result = vim.tbl_map(formatter,hl_groups)
	return result
end
return M

