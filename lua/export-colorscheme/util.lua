local M = {}

M.rgb_to_hex = function(rgb)
	return string.format("%06x", rgb)
end

M.interp = function(s, tab)
  return (s:gsub('(~%b<>)', function(w) return tab[w:sub(3, -2)] or w end))
end

M.map = function(f, t)
    local t1 = {}
    local t_len = #t
    for i = 1, t_len do
        t1[i] = f(t[i])
    end
    return t1
end

M.find_val = function(tbl, fd)
	for key, val in pairs(tbl) do
		if key == fd then return val end
	end
end

return M
