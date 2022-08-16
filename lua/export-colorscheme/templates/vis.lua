local M = {}
local util = require"export-colorscheme.util"
M.name = "vis"
M.extension = "lua"
M.content = [[local lexers = vis.lexers

lexers.STYLE_DEFAULT = '~<Normal>'
lexers.STYLE_NOTHING = ''
lexers.STYLE_COMMENT = '~<Comment>'
lexers.STYLE_CONSTANT = '~<Constant>'
lexers.STYLE_ERROR = '~<ErrorMsg>'
lexers.STYLE_FUNCTION = '~<Function>'
lexers.STYLE_KEYWORD = '~<Keyword>'
lexers.STYLE_LABEL = '~<Label>'
lexers.STYLE_NUMBER = '~<Number>'
lexers.STYLE_OPERATOR = '~<Operator>'
lexers.STYLE_STRING = '~<String>'
lexers.STYLE_PREPROCESSOR = '~<PreProc>'
lexers.STYLE_TAG = '~<Tag>'
lexers.STYLE_TYPE = '~<Type>'
lexers.STYLE_WHITESPACE = '~<Whitespace>'
lexers.STYLE_IDENTIFIER = '~<Identifier>'

lexers.STYLE_LINENUMBER = '~<LineNr>'
lexers.STYLE_LINENUMBER_CURSOR =  '~<CursorLineNr>'
lexers.STYLE_CURSOR = '~<CursorLineNr>'
lexers.STYLE_CURSOR_PRIMARY = '~<Search>'
lexers.STYLE_CURSOR_LINE = '~<CursorLine>'
lexers.STYLE_COLOR_COLUMN = '~<ColorColumn>'
lexers.STYLE_SELECTION = '~<Visual>'
lexers.STYLE_STATUS = '~<StatusLineNC>'
lexers.STYLE_STATUS_FOCUSED = '~<StatusLine>'
lexers.STYLE_EOF = '~<LineNr>']]

local function formatter(tbl)
	local style_string = ""
	local sep = ""
	for attr, val in pairs(tbl) do
		local formatted_attr = ''
		if attr == "foreground" then
			formatted_attr = "fore:#" .. util.rgb_to_hex(val)
		elseif attr == "background" then
			formatted_attr = "back:#" .. util.rgb_to_hex(val)
		elseif attr == "bold" then
			formatted_attr = "bold"
		elseif attr == "italics" then
			formatted_attr = "italics"
		elseif attr == "reverse" then
			formatted_attr = "reverse"
		end
		style_string = style_string .. sep .. formatted_attr
		if formatted_attr ~= '' then sep = "," end
	end
	return style_string
end

M.make_interpolation_table = function(hl_groups)
	local result = {}
	result = vim.tbl_map(formatter,hl_groups)
	return result
end

return M

