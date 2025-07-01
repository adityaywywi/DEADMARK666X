local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local seedsToBuy = {}
local autoBuyEnabled = false

-- UI SETUP
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "SeedAutoBuyUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 250)
Frame.Position = UDim2.new(0, 10, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", Frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🌱 Auto Seed Buyer"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16

-- Dropdown (manual input for now)
local seedOptions = {"Tomato", "Carrot", "Lettuce", "Apple"} -- Tambahkan seed sesuai kebutuhan
for i, seedName in ipairs(seedOptions) do
	local button = Instance.new("TextButton", Frame)
	button.Size = UDim2.new(1, -20, 0, 25)
	button.Position = UDim2.new(0, 10, 0, 30 + (i - 1) * 30)
	button.Text = "[ ] " .. seedName
	button.TextColor3 = Color3.new(1,1,1)
	button.BackgroundColor3 = Color3.fromRGB(60,60,60)
	button.Font = Enum.Font.SourceSans
	button.TextSize = 14

	button.MouseButton1Click:Connect(function()
		if seedsToBuy[seedName] then
			seedsToBuy[seedName] = nil
			button.Text = "[ ] " .. seedName
		else
			seedsToBuy[seedName] = true
			button.Text = "[✔] " .. seedName
		end
	end)
end

-- Toggle auto-buy
local toggle = Instance.new("TextButton", Frame)
toggle.Size = UDim2.new(1, -20, 0, 30)
toggle.Position = UDim2.new(0, 10, 0, 30 + #seedOptions * 30)
toggle.Text = "Auto-Buy: OFF"
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.BackgroundColor3 = Color3.fromRGB(100, 50, 50)
toggle.Font = Enum.Font.SourceSansBold
toggle.TextSize = 14

toggle.MouseButton1Click:Connect(function()
	autoBuyEnabled = not autoBuyEnabled
	toggle.Text = "Auto-Buy: " .. (autoBuyEnabled and "ON" or "OFF")
	toggle.BackgroundColor3 = autoBuyEnabled and Color3.fromRGB(50, 100, 50) or Color3.fromRGB(100, 50, 50)
end)

-- Auto-buy loop
task.spawn(function()
	while true do
		if autoBuyEnabled then
			local shop = workspace:FindFirstChild("Interaction") and workspace.Interaction:FindFirstChild("Updateltems") and workspace.Interaction.Updateltems:FindFirstChild("HarvestShop")
			if shop then
				for _, item in ipairs(shop:GetChildren()) do
					if seedsToBuy[item.Name] then
						ReplicatedStorage.GameEvents.BuySeedStock:FireServer(item.Name, 1)
						warn("[AUTO BUY] Bought seed:", item.Name)
						task.wait(0.5)
					end
				end
			end
		end
		task.wait(5)
	end
end)
