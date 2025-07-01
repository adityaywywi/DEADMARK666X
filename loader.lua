-- Deadmark GAG Loader (ESP Egg with UI)
local function espEggs()
    for _, egg in pairs(workspace:GetDescendants()) do
        if egg:IsA("Model") and egg:FindFirstChild("PetName") and not egg:FindFirstChild("ESPLabel") then
            local gui = Instance.new("BillboardGui", egg)
            gui.Name = "ESPLabel"
            gui.Size = UDim2.new(0, 100, 0, 30)
            gui.StudsOffset = Vector3.new(0, 2, 0)
            gui.AlwaysOnTop = true

            local label = Instance.new("TextLabel", gui)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = egg.PetName.Value
            label.TextColor3 = Color3.fromRGB(0, 255, 0)
            label.TextScaled = true
            label.Font = Enum.Font.SourceSansBold
        end
    end
end

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "DeadmarkUI"

local main = Instance.new("Frame", ScreenGui)
main.Size = UDim2.new(0, 250, 0, 150)
main.Position = UDim2.new(0.5, -125, 0.5, -75)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Text = "Deadmark ESP"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold

local btn = Instance.new("TextButton", main)
btn.Position = UDim2.new(0.1, 0, 0.4, 0)
btn.Size = UDim2.new(0.8, 0, 0.3, 0)
btn.Text = "Enable Egg ESP"
btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.TextScaled = true
btn.Font = Enum.Font.SourceSansBold
btn.MouseButton1Click:Connect(espEggs)
