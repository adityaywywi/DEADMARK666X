-- ✅ Modern Auto-Buy Seeds UI [Grow a Garden]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local SEED_LIST = {
    "Carrot Seed", "Strawberry Seed", "Blueberry Seed", "Tomato Seed",
    "Cauliflower Seed", "Watermelonr Seed", "Raffleisa Seed", "Green Apple Seed",
    "Avocado Seed", "Banana Seed", "Pineapple Seed", "Kiwi Seed", "Bell Pepper Seed",
    "Prickly Pear Seed", "Loquat Seed", "Feijoa Seed", "Pitcher Plant", "Sugar Apple"
}

local selectedSeeds = {}
local autoBuy = false

-- ✅ UI Setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "666X_UI"

local holder = Instance.new("Frame", gui)
holder.Name = "MainUI"
holder.Size = UDim2.new(0, 250, 0, 300)
holder.Position = UDim2.new(0, 20, 0.5, -150)
holder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
holder.BorderSizePixel = 0
holder.Active = true
holder.Draggable = true

local title = Instance.new("TextLabel", holder)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "🌱 Auto-Buy Seeds"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.new(1, 1, 1)

-- Scrollable Container
local scroll = Instance.new("ScrollingFrame", holder)
scroll.Position = UDim2.new(0, 10, 0, 35)
scroll.Size = UDim2.new(1, -20, 1, -75)
scroll.CanvasSize = UDim2.new(0, 0, 0, #SEED_LIST * 30)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1

for i, seed in ipairs(SEED_LIST) do
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, 0, 0, 28)
    btn.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
    btn.Text = "[ ] " .. seed
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    btn.MouseButton1Click:Connect(function()
        if selectedSeeds[seed] then
            selectedSeeds[seed] = nil
            btn.Text = "[ ] " .. seed
        else
            selectedSeeds[seed] = true
            btn.Text = "[✔] " .. seed
        end
    end)
end

-- Toggle Button
local toggle = Instance.new("TextButton", holder)
toggle.Size = UDim2.new(1, -20, 0, 30)
toggle.Position = UDim2.new(0, 10, 1, -35)
toggle.Text = "Auto-Buy: OFF"
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 14
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.BackgroundColor3 = Color3.fromRGB(100, 30, 30)

toggle.MouseButton1Click:Connect(function()
    autoBuy = not autoBuy
    toggle.Text = "Auto-Buy: " .. (autoBuy and "ON" or "OFF")
    toggle.BackgroundColor3 = autoBuy and Color3.fromRGB(30, 100, 30) or Color3.fromRGB(100, 30, 30)
end)

-- ✅ Auto-Buy Logic
task.spawn(function()
    while true do
        if autoBuy then
            local harvestShop = workspace:FindFirstChild("Interaction")
                and workspace.Interaction:FindFirstChild("Updateltems")
                and workspace.Interaction.Updateltems:FindFirstChild("HarvestShop")
            
            if harvestShop then
                local buyRemote = ReplicatedStorage:FindFirstChild("GameEvents")
                    and ReplicatedStorage.GameEvents:FindFirstChild("BuySeedStock")

                if buyRemote then
                    for _, item in ipairs(harvestShop:GetChildren()) do
                        if selectedSeeds[item.Name] and item:FindFirstChild("Stock") and item.Stock.Value > 0 then
                            pcall(function()
                                buyRemote:FireServer(item.Name, 1)
                            end)
                            task.wait(0.2)
                        end
                    end
                end
            end
        end
        task.wait(4)
    end
end)

print("[✅ UI Loaded Successfully]")
