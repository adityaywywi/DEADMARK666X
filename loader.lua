local url = "https://raw.githubusercontent.com/adityaywywi/DEADMARK666X/main/gag.lua"
local success, result = pcall(function()
	return game:HttpGet(url)
end)

if success then
	loadstring(result)()
else
	warn("[LOADER] Failed to fetch gag.lua:", result)
end
