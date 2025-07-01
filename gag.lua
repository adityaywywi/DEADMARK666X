local gui = Instance.new("ScreenGui")
gui.Name = "UI_Test"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

local test = Instance.new("TextLabel", gui)
test.Text = "Hello World"
test.Size = UDim2.new(0, 200, 0, 50)
test.Position = UDim2.new(0, 50, 0, 50)
test.TextColor3 = Color3.new(1, 1, 1)

-- ✅ MODERN AUTO-BUY UI DESIGN
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local seeds = {"Tomato", "Carrot", "Apple", "Peach", "Coconut", "Beanstalk", "Moon Melon", "Blood Banana", "Dragon Fruit"}
local selected = {}
local autoBuy = false

-- UI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "BetterAutoBuyUI"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 250, 0, 60 + (#seeds * 28))
main.Position = UDim2.new(0, 20, 0, 100)
main.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
main.BorderSizePixel = 0
main.BackgroundTransparency = 0.1
main.ClipsDescendants = true
main.AnchorPoint = Vector2.new(0, 0)
main.ZIndex = 2
main.Name = "AutoBuyFrame"
main:SetAttribute("Rounded", true)

-- UICorner
local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🌱 Auto-Buy Seeds"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

-- Checkboxes
for i, name in ipairs(seeds) do
	local btn = Instance.new("TextButton", main)
	btn.Size = UDim2.new(1, -30, 0, 25)
	btn.Position = UDim2.new(0, 15, 0, 30 + (i - 1) * 28)
	btn.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Text = "[ ] " .. name
	btn.AutoButtonColor = true

	local rounded = Instance.new("UICorner", btn)
	rounded.CornerRadius = UDim.new(0, 8)

	btn.MouseButton1Click:Connect(function()
		if selected[name] then
			selected[name] = nil
			btn.Text = "[ ] " .. name
		else
			selected[name] = true
			btn.Text = "[✔] " .. name
		end
	end)
end

-- Toggle
local toggle = Instance.new("TextButton", main)
toggle.Size = UDim2.new(0.9, 0, 0, 30)
toggle.Position = UDim2.new(0.05, 0, 1, -35)
toggle.BackgroundColor3 = Color3.fromRGB(255, 90, 90)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 16
toggle.Text = "Start Auto-Buy"

local round = Instance.new("UICorner", toggle)
round.CornerRadius = UDim.new(0, 10)

toggle.MouseButton1Click:Connect(function()
	autoBuy = not autoBuy
	toggle.Text = autoBuy and "Stop Auto-Buy" or "Start Auto-Buy"
	toggle.BackgroundColor3 = autoBuy and Color3.fromRGB(90, 255, 90) or Color3.fromRGB(255, 90, 90)
end)
