-- ✅ AUTO-BUY SEED WITH UI (GROW A GARDEN)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- ✅ Nama-nama seed yang sesuai dengan toko
local SEED_LIST = {
    "Carrot Seed",
    "Strawberry Seed",
    "Blueberry Seed",
    "Tomato Seed",
    "Cauliflower Seed",
    "Watermelonr Seed",
    "Raffleisa Seed",
    "Green Apple Seed",
    "Avocado Seed",
    "Banana Seed",
    "Pineapple Seed",
    "Kiwi Seed",
    "Bell Pepper Seed",
    "Prickly Pear Seed",
    "Loquat Seed",
    "Feijoa Seed",
    "Pitcher Plant",
    "Sugar Apple" -- ✅ tanpa "Seed"
}

-- ✅ UI dan logic
local selectedSeeds = {}
local autoBuy = false

local gui = Instance.new("ScreenGui")
gui.Name = "AutoSeedUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 230, 0, 40 + #SEED_LIST * 25 + 40)
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

task.spawn(function()
	while true do
		if autoBuy then
			local shopFolder = workspace:FindFirstChild("Interaction")
			if not shopFolder then warn("❌ Folder 'Interaction' tidak ditemukan") task.wait(5) continue end

			local updateItems = shopFolder:FindFirstChild("Updateltems")
			if not updateItems then warn("❌ Folder 'Updateltems' tidak ditemukan") task.wait(5) continue end

			local harvestShop = updateItems:FindFirstChild("HarvestShop")
			if not harvestShop then warn("❌ Folder 'HarvestShop' tidak ditemukan") task.wait(5) continue end

			local buyRemote = ReplicatedStorage:FindFirstChild("GameEvents"):FindFirstChild("BuySeedStock")
			if not buyRemote then warn("❌ RemoteEvent 'BuySeedStock' tidak ditemukan") task.wait(5) continue end

			for _, item in pairs(harvestShop:GetChildren()) do
				if selectedSeeds[item.Name] and item:FindFirstChild("Stock") and item.Stock.Value > 0 then
					print("[AUTO BUY] 🔄 Membeli:", item.Name)
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
