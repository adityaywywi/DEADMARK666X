-- ✅ AUTO-BUY SEED UI SCRIPT FOR GROW A GARDEN
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local SEED_LIST = {
    "Tomato", "Carrot", "Lettuce", "Apple", "Coconut", "Peach",
    "Beanstalk", "Moon Melon", "Blood Banana", "Dragon Fruit"
}

local selectedSeeds = {}
local autoBuy = false

-- ✅ UI SETUP
local gui = Instance.new("ScreenGui")
gui.Name = "AutoSeedUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 60 + #SEED_LIST * 28)
frame.Position = UDim2.new(0.5, -140, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 35)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🌱 DEADMARK666X Auto-Buy Seeds"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundTransparency = 1

-- ✅ CHECKBOX LIST
for i, seedName in ipairs(SEED_LIST) do
    local button = Instance.new("TextButton", frame)
    button.Size = UDim2.new(1, -20, 0, 25)
    button.Position = UDim2.new(0, 10, 0, 35 + (i - 1) * 28)
    button.Text = "[ ] " .. seedName
    button.TextColor3 = Color3.new(1, 1, 1)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14

    button.MouseButton1Click:Connect(function()
        if selectedSeeds[seedName] then
            selectedSeeds[seedName] = nil
            button.Text = "[ ] " .. seedName
        else
            selectedSeeds[seedName] = true
            button.Text = "[✔] " .. seedName
        end
    end)
end

-- ✅ TOGGLE BUTTON
local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Size = UDim2.new(1, -20, 0, 35)
toggleBtn.Position = UDim2.new(0, 10, 0, 35 + #SEED_LIST * 28)
toggleBtn.Text = "🚫 Auto-Buy: OFF"
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 50)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 16

toggleBtn.MouseButton1Click:Connect(function()
    autoBuy = not autoBuy
    toggleBtn.Text = autoBuy and "✅ Auto-Buy: ON" or "🚫 Auto-Buy: OFF"
    toggleBtn.BackgroundColor3 = autoBuy and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(100, 50, 50)
end)

-- ✅ AUTO-BUY LOGIC
task.spawn(function()
    while true do
        if autoBuy then
            local shopFolder = workspace:FindFirstChild("Interaction")
            local updateItems = shopFolder and shopFolder:FindFirstChild("Updateltems")
            local harvestShop = updateItems and updateItems:FindFirstChild("HarvestShop")

            local events = ReplicatedStorage:FindFirstChild("GameEvents")
            local buyRemote = events and events:FindFirstChild("BuySeedStock")

            if harvestShop and buyRemote then
                for _, item in pairs(harvestShop:GetChildren()) do
                    if selectedSeeds[item.Name] and item:FindFirstChild("Stock") and item.Stock.Value > 0 then
                        pcall(function()
                            buyRemote:FireServer(item.Name, 1)
                            warn("[✅ AUTO BUY] Buying:", item.Name)
                        end)
                        task.wait(0.4)
                    end
                end
            else
                warn("[❌ AUTO BUY] HarvestShop or BuySeedStock not found!")
            end
        end
        task.wait(5)
    end
end)

warn("✅ UI loaded successfully!")
