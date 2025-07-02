-- ✅ DEADMARK666X Script Entry Point (gag.lua)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DeadmarkFolder = ReplicatedStorage:WaitForChild("DEADMARK666X")
local Modules = DeadmarkFolder:WaitForChild("Modules")

-- Fungsi aman untuk require module
local function safeRequire(moduleName)
	local success, result = pcall(function()
		return require(Modules:WaitForChild(moduleName))
	end)
	if not success then
		warn("[DEADMARK] Gagal require:", moduleName, "|", result)
	end
	return result
end

-- ✅ Load UI dan AutoBuy
local ui = safeRequire("Ui")
if ui then
	pcall(ui.Show)
end

local autobuy = safeRequire("Autobuy")
if autobuy then
	pcall(autobuy.Start)
end

warn("[DEADMARK] ✅ gag.lua loaded successfully.")
