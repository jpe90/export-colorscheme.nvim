local M = {}
local util = require"export-colorscheme.util"
M.name = "kakoune"
M.extension = "kak"
M.content = [[# For Code
face global value ~<Number>
face global type ~<Type>
face global variable ~<Identifier>
face global module ~<Identifier>
face global function ~<Function>
face global string ~<String>
face global keyword ~<Keyword>
face global operator ~<Operator>
face global attribute ~<Identifier>
face global comment ~<Comment>
face global documentation comment
face global meta ~<String>
face global builtin default+b

# For markup
face global title ~<Keyword>
face global header ~<Function>
face global mono ~<Identifier>
face global block ~<String>
face global link ~<Function>
face global bullet ~<Function>
face global list ~<Type>

# builtin faces
face global Default ~<Normal>
face global PrimarySelection ~<PrimarySelection>
face global SecondarySelection ~<SecondarySelection>
face global PrimaryCursor black,white+fg
face global SecondaryCursor black,white+fg
face global PrimaryCursorEol black,~<Function>+fg
face global SecondaryCursorEol black,~<Function>+fg
face global LineNumbers default,default
face global LineNumberCursor default,default+r
face global MenuForeground ~<Pmenu>
face global MenuBackground ~<PmenuRev>
face global MenuInfo ~<Function>
face global Information black,~<Type>
face global Error black,~<Number>
face global DiagnosticError ~<ErrorMsg>
face global DiagnosticWarning ~<WarningMsg>
face global StatusLine ~<Normal>
face global StatusLineMode ~<Type>
face global StatusLineInfo ~<Keyword>
face global StatusLineValue ~<Identifier>
face global StatusCursor black,~<Function>
face global Prompt ~<Type>,default
face global MatchingChar default,default+b
face global Whitespace default,default+fd
face global BufferPadding ~<Keyword>,default]]

-- kakoune styles are defined by a foreground color, optionally followed by a 
-- comma and a background color
local formatter = function(attrs)
	local color_string = ""
	local fmt = function(attr)
		return "rgb:" .. util.rgb_to_hex(attr)
	end
	if attrs.foreground ~= nil then
		color_string = fmt(attrs.foreground)
		if attrs.background ~= nil then
			color_string = color_string .. ',' .. fmt(attrs.background)
		end
	elseif attrs.background ~= nil then
		color_string = fmt(attrs.background)
	end
	return color_string
end

M.make_interpolation_table = function(hl_groups)
	-- kakoune has UI concepts that do not exist in vim
	-- define extra groups from existing vim groups
	local nml = util.find_val(hl_groups,"Normal")
	hl_groups["NormalRev"] = {background=nml.foreground, foreground = nml.background}
	local pmenu = util.find_val(hl_groups,"Pmenu")
	local visual = util.find_val(hl_groups,"Visual")
	hl_groups["PmenuRev"] = {background=pmenu.foreground, foreground = pmenu.background}
	hl_groups["PrimarySelection"] = {background=visual.background, foreground = nml.foreground}
	hl_groups["SecondarySelection"] = {background=visual.background, foreground = nml.background}

	local intp_tbl = {}
	intp_tbl = vim.tbl_map(formatter,hl_groups)
	return intp_tbl
end

return M
