-- DeadMark666X | Auto-Buy Seed UI v2
local plr = game:GetService("Players").LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local ws = game:GetService("Workspace")

local SEED_NAMES = {
	"Carrot Seed", "Strawberry Seed", "Blueberry Seed", "Tomato Seed", "Cauliflower Seed",
	"Watermelonr Seed", "Raffleisa Seed", "Green Apple Seed", "Avocado Seed", "Banana Seed",
	"Pineapple Seed", "Kiwi Seed", "Bell Pepper Seed", "Prickly Pear Seed", "Loquat Seed",
	"Feijoa Seed", "Pitcher Plant", "Sugar Apple"
}

local chosen = {}
local autoBuy = false

-- UI Setup
local gui = Instance.new("ScreenGui", plr.PlayerGui)
gui.Name = "DeadMark_SeedUI"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 250, 0, 420)
main.Position = UDim2.new(0, 10, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.BackgroundTransparency = 0.2

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🌱 Auto-Buy Seeds"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local toggle = Instance.new("TextButton", main)
toggle.Size = UDim2.new(1, -20, 0, 30)
toggle.Position = UDim2.new(0, 10, 0, 370)
toggle.Text = "Auto-Buy: OFF"
toggle.BackgroundColor3 = Color3.fromRGB(100, 30, 30)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 14

toggle.MouseButton1Click:Connect(function()
	autoBuy = not autoBuy
	toggle.Text = autoBuy and "Auto-Buy: ON" or "Auto-Buy: OFF"
	toggle.BackgroundColor3 = autoBuy and Color3.fromRGB(40, 100, 40) or Color3.fromRGB(100, 30, 30)
end)

-- Checkboxes
for i, seed in ipairs(SEED_NAMES) do
	local b = Instance.new("TextButton", main)
	b.Size = UDim2.new(1, -20, 0, 22)
	b.Position = UDim2.new(0, 10, 0, 30 + (i - 1) * 22)
	b.Text = "[ ] " .. seed
	b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	b.TextColor3 = Color3.new(1, 1, 1)
	b.Font = Enum.Font.Gotham
	b.TextSize = 13
	b.AutoButtonColor = true

	b.MouseButton1Click:Connect(function()
		chosen[seed] = not chosen[seed]
		b.Text = (chosen[seed] and "[✔] " or "[ ] ") .. seed
	end)
end

-- Auto-buy core
task.spawn(function()
	while true do
		if autoBuy then
			local shop = ws:FindFirstChild("Interaction") and ws.Interaction:FindFirstChild("Updateltems") and ws.Interaction.Updateltems:FindFirstChild("HarvestShop")
			if shop then
				for _, item in ipairs(shop:GetChildren()) do
					if chosen[item.Name] and item:FindFirstChild("Stock") and item.Stock.Value > 0 then
						local event = rs:FindFirstChild("GameEvents") and rs.GameEvents:FindFirstChild("BuySeedStock")
						if event then
							event:FireServer(item.Name, 1)
							warn("[AUTO-BUY] Bought:", item.Name)
							task.wait(0.3)
						end
					end
				end
			else
				warn("[AUTO-BUY] ❌ HarvestShop not found")
			end
		end
		task.wait(4)
	end
end)

print("✅ Auto-Buy Seed UI Loaded by DeadMark666X")
