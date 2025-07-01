-- ✅ AUTO-BUY SEED WITH UI (FOR GROW A GARDEN)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- Konfigurasi daftar seed
local SEED_LIST = {"Tomato", "Carrot", "Grape", "Apple", "Coconut", "Peach", "Beanstalk", "Moon Melon", "Blood Banana", "Dragon Fruit"}

-- Variabel state
local selectedSeeds = {}
local autoBuy = false

-- ✅ BUAT UI
local gui = Instance.new("ScreenGui")
gui.Name = "AutoSeedUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 40 + #SEED_LIST * 25 + 40)
frame.Position = UDim2.new(0, 10, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🌱 Auto-Buy Seeds"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18

-- ✅ CheckBox per seed
for i, seedName in ipairs(SEED_LIST) do
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(1, -20, 0, 22)
	btn.Position = UDim2.new(0, 10, 0, 30 + (i - 1) * 25)
	btn.Text = "[ ] " .. seedName
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 14

	btn.MouseButton1Click:Connect(function()
		if selectedSeeds[seedName] then
			selectedSeeds[seedName] = nil
			btn.Text = "[ ] " .. seedName
		else
			selectedSeeds[seedName] = true
			btn.Text = "[✔] " .. seedName
		end
	end)
end

-- ✅ Tombol toggle
local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(1, -20, 0, 30)
toggle.Position = UDim2.new(0, 10, 0, 30 + #SEED_LIST * 25)
toggle.Text = "Auto-Buy: OFF"
toggle.BackgroundColor3 = Color3.fromRGB(100, 50, 50)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.SourceSansBold
toggle.TextSize = 14

toggle.MouseButton1Click:Connect(function()
	autoBuy = not autoBuy
	toggle.Text = "Auto-Buy: " .. (autoBuy and "ON" or "OFF")
	toggle.BackgroundColor3 = autoBuy and Color3.fromRGB(50, 100, 50) or Color3.fromRGB(100, 50, 50)
end)

-- ✅ Auto-buy logic
task.spawn(function()
	while true do
		if autoBuy then
			local shopFolder = workspace:FindFirstChild("Interaction")
			if not shopFolder then
				warn("[AUTO BUY] ❌ Interaction folder not found")
				task.wait(5)
				continue
			end

			-- Tambahkan debug isi folder
			for _, obj in ipairs(shopFolder:GetChildren()) do
				print("[DEBUG] Folder in Interaction:", obj.Name)
			end

			-- Cari updateItems (coba dua kemungkinan penulisan)
			local updateItems = shopFolder:FindFirstChild("UpdateItems") or shopFolder:FindFirstChild("Updateltems")
			if not updateItems then
				warn("[AUTO BUY] ❌ UpdateItems folder not found")
				task.wait(5)
				continue
			end

			local harvestShop = updateItems:FindFirstChild("HarvestShop")
			if not harvestShop then
				warn("[AUTO BUY] ❌ HarvestShop not found")
				task.wait(5)
				continue
			end

			local event = ReplicatedStorage:FindFirstChild("GameEvents")
			if not event or not event:FindFirstChild("BuySeedStock") then
				warn("[AUTO BUY] ❌ BuySeedStock remote not found")
				task.wait(5)
				continue
			end

			local buyRemote = event.BuySeedStock

			for _, item in pairs(harvestShop:GetChildren()) do
				if selectedSeeds[item.Name] and item:FindFirstChild("Stock") and item.Stock.Value > 0 then
					print("[AUTO BUY] 🔄 Buying:", item.Name)
					pcall(function()
						buyRemote:FireServer(item.Name, 1)
					end)
					task.wait(0.3)
				end
			end
		end
		task.wait(5)
	end
end)
