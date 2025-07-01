local EggContents = {
    ["Pet Egg"] = {"Bunny", "Dog", "Golden Lab"},
    ["Uncommon Egg"] = {"Black Bunny", "Cat", "Chicken", "Deer"},
    ["Rare Egg"] = {"Orange Tabby", "Spotted Deer", "Pig", "Rooster", "Monkey"},
    ["Legendary Egg"] = {"Cow", "Silver Monkey", "Sea Otter", "Polar Bear", "Turtle"},
    ["Mythical Egg"] = {"Grey Mouse", "Brown Mouse", "Squirrel", "Red Giant Ant", "Red Fox"},
    ["Paradise Egg"] = {"Ostrich", "Peacock", "Capybara", "Scarlet Macaw", "Mimic Octopus"},
    ["Common Summer Egg"] = {"Starfish", "Seagull", "Crab"},
    ["Rare Summer Egg"] = {"Flamingo", "Toucan", "Sea Turtle", "Orangutan", "Seal"},
    ["Night Egg"] = {"Hedgehog", "Kiwi", "Mole", "Echo Frog", "Night Owl"}
}

local function createESPFromModel(model)
    if not model:GetAttribute("EggName") then return end
    if not model:GetAttribute("OBJECT_TYPE") == "PetEgg" then return end

    local part = model:FindFirstChild("PetEgg")
    if not part or not part:IsA("BasePart") then return end
    if part:FindFirstChild("ESPLabel") then return end

    local eggName = model:GetAttribute("EggName")
    local pets = EggContents[eggName]
    if not pets then return end

    print("[ESP] Loaded:", eggName)

    local gui = Instance.new("BillboardGui", part)
    gui.Name = "ESPLabel"
    gui.Adornee = part
    gui.Size = UDim2.new(0, 200, 0, 40)
    gui.StudsOffset = Vector3.new(0, 3, 0)
    gui.AlwaysOnTop = true

    local label = Instance.new("TextLabel", gui)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 0.3
    label.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    label.TextColor3 = Color3.fromRGB(0, 255, 0)
    label.TextScaled = true
    label.Font = Enum.Font.SourceSansBold
    label.Text = table.concat(pets, ", ")
end

local function scanAllEggs()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:GetAttribute("OBJECT_TYPE") == "PetEgg" then
            createESPFromModel(obj)
        end
    end
end

-- UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "DeadmarkESPUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.Position = UDim2.new(0.05, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Text = "DEADMARK ESP"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextScaled = true

local EnableBtn = Instance.new("TextButton", Frame)
EnableBtn.Size = UDim2.new(0.9, 0, 0, 35)
EnableBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
EnableBtn.Text = "Enable Egg ESP"
EnableBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
EnableBtn.TextColor3 = Color3.new(1, 1, 1)
EnableBtn.Font = Enum.Font.SourceSansBold
EnableBtn.TextScaled = true

local DisableBtn = Instance.new("TextButton", Frame)
DisableBtn.Size = UDim2.new(0.9, 0, 0, 35)
DisableBtn.Position = UDim2.new(0.05, 0, 0.7, 0)
DisableBtn.Text = "Disable ESP"
DisableBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
DisableBtn.TextColor3 = Color3.new(1, 1, 1)
DisableBtn.Font = Enum.Font.SourceSansBold
DisableBtn.TextScaled = true

EnableBtn.MouseButton1Click:Connect(function()
    print("[ESP] Scanning all eggs...")
    scanAllEggs()
    workspace.DescendantAdded:Connect(function(obj)
        if obj:IsA("Model") and obj:GetAttribute("OBJECT_TYPE") == "PetEgg" then
            createESPFromModel(obj)
        end
    end)
end)

DisableBtn.MouseButton1Click:Connect(function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v:FindFirstChild("ESPLabel") then
            v.ESPLabel:Destroy()
        end
    end
end)

print("[ESP] Script loaded.")
