local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ✅ TEST GUI
local gui = Instance.new("ScreenGui")
gui.Name = "TestAutoSeedUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0, 100, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 0, 40)
label.Position = UDim2.new(0, 0, 0, 0)
label.Text = "🌱 UI LOADED SUCCESSFULLY"
label.Font = Enum.Font.SourceSansBold
label.TextSize = 18
label.TextColor3 = Color3.new(1, 1, 1)
label.BackgroundTransparency = 1
label.Parent = frame
