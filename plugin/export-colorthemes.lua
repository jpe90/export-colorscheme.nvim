local ecs = require("export-colorscheme")
vim.api.nvim_create_user_command("Ecs", function(opts)
	require("export-colorscheme").run(opts)
end, {

-- so this should only have its current behavior on the first arg
-- for args 2..n, it should eventually have a filtered list of all colorschemes
complete = function ()
	local template_names = {}
	for _, value in ipairs(ecs.templates) do
		table.insert(template_names,value.name)
	end
	return template_names
end,
nargs = 1,
bang = true })

