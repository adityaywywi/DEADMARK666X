local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local SEED_LIST = {"Tomato", "Carrot", "Lettuce", "Apple", "Peach", "Beanstalk", "Moon Melon", "Blood Banana", "Coconut", "Dragon Fruit"}
local selectedSeeds = {}
local autoBuy = false

-- 🧱 Setup GUI
local gui = Instance.new("ScreenGui")
gui.Name = "BetterSeedUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 400)
frame.Position = UDim2.new(0, 15, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "🌱 Seed Auto-Buy"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Parent = frame

-- 🧾 Checkbox List
for i, seedName in ipairs(SEED_LIST) do
	local checkbox = Instance.new("TextButton")
	checkbox.Size = UDim2.new(1, -20, 0, 25)
	checkbox.Position = UDim2.new(0, 10, 0, 35 + (i - 1) * 28)
	checkbox.Text = "[ ] " .. seedName
	checkbox.Font = Enum.Font.Gotham
	checkbox.TextSize = 14
	checkbox.TextColor3 = Color3.new(1,1,1)
	checkbox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	checkbox.AutoButtonColor = false
	checkbox.Parent = frame

	checkbox.MouseButton1Click:Connect(function()
		if selectedSeeds[seedName] then
			selectedSeeds[seedName] = nil
			checkbox.Text = "[ ] " .. seedName
		else
			selectedSeeds[seedName] = true
			checkbox.Text = "[✔] " .. seedName
		end
	end)
end

-- 🔘 Toggle Button
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(1, -20, 0, 35)
toggle.Position = UDim2.new(0, 10, 0, 35 + #SEED_LIST * 28)
toggle.Text = "Auto-Buy: OFF"
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 16
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.BackgroundColor3 = Color3.fromRGB(100, 30, 30)
toggle.AutoButtonColor = false
toggle.Parent = frame

toggle.MouseButton1Click:Connect(function()
	autoBuy = not autoBuy
	toggle.Text = "Auto-Buy: " .. (autoBuy and "ON" or "OFF")
	toggle.BackgroundColor3 = autoBuy and Color3.fromRGB(30, 100, 30) or Color3.fromRGB(100, 30, 30)
end)

-- 🛒 Auto-Buy Logic
task.spawn(function()
	while true do
		if autoBuy then
			local shop = workspace:FindFirstChild("Interaction") and workspace.Interaction:FindFirstChild("Updateltems") and workspace.Interaction.Updateltems:FindFirstChild("HarvestShop")
			local buyRemote = ReplicatedStorage:FindFirstChild("GameEvents") and ReplicatedStorage.GameEvents:FindFirstChild("BuySeedStock")

			if shop and buyRemote then
				for _, item in pairs(shop:GetChildren()) do
					if selectedSeeds[item.Name] and item:FindFirstChild("Stock") and item.Stock.Value > 0 then
						buyRemote:FireServer(item.Name, 1)
						print("[AUTO-BUY] Bought:", item.Name)
						task.wait(0.3)
					end
				end
			end
		end
		task.wait(4)
	end
end)
