-- ✅ ESP + Auto Farm GROW A GARDEN - Only Your Eggs

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ESP_COLOR = Color3.fromRGB(255, 255, 0)
local TEXT_SIZE = 14

local function createESP(part, text)
    if part:FindFirstChild("PetESP") then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PetESP"
    billboard.Size = UDim2.new(0, 200, 0, 30)
    billboard.Adornee = part
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 3, 0)

    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = ESP_COLOR
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = TEXT_SIZE
    label.TextStrokeTransparency = 0.5

    billboard.Parent = part
end

local function getPetName(model)
    for _, child in ipairs(model:GetChildren()) do
        if child:IsA("Model") and not child.Name:find("HitBox") then
            return child.Name
        end
    end
    return model:GetAttribute("EggName") or "PetEgg"
end

local function scanEggs()
    for _, egg in ipairs(workspace:GetDescendants()) do
        if egg:IsA("Model") and egg:GetAttribute("OBJECT_TYPE") == "PetEgg" and egg:GetAttribute("OWNER") == LocalPlayer.Name then
            local part = egg:FindFirstChildWhichIsA("BasePart")
            if part and not part:FindFirstChild("PetESP") then
                local name = getPetName(egg)
                createESP(part, name)
                print("[ESP] Loaded: " .. name)
            end
        end
    end
end

-- AUTO FEATURES
local autoCollect, autoSeed, autoSubmit = false, false, false

task.spawn(function()
    while true do
        if autoCollect then
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer("CollectAll")
        end
        task.wait(3)
    end
end)

task.spawn(function()
    while true do
        if autoSeed then
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer("BuySeed", "Tomato")
        end
        task.wait(5)
    end
end)

task.spawn(function()
    while true do
        if autoSubmit then
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer("SubmitFruit", "Summer")
        end
        task.wait(5)
    end
end)

-- UI
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "DM666XUI"

local function createButton(name, pos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, pos)
    btn.Text = name
    btn.BackgroundColor3 = Color3.new(0, 0, 0.2)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Parent = ScreenGui
    btn.MouseButton1Click:Connect(callback)
end

createButton("Enable ESP", 10, function()
    print("[DM666X] ESP Enabled")
    task.spawn(function()
        while true do
            pcall(scanEggs)
            task.wait(2.5)
        end
    end)
end)

createButton("Auto Collect", 50, function()
    autoCollect = not autoCollect
    print("[DM666X] Auto Collect:", autoCollect)
end)

createButton("Auto Buy Seed", 90, function()
    autoSeed = not autoSeed
    print("[DM666X] Auto Seed:", autoSeed)
end)

createButton("Auto Submit Summer", 130, function()
    autoSubmit = not autoSubmit
    print("[DM666X] Auto Submit:", autoSubmit)
end)

print("[DEADMARK666X] UI Loaded.")
