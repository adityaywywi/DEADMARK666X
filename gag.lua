local ESP_COLOR = Color3.fromRGB(255, 255, 0)
local FONT = Enum.Font.SourceSansBold
local TEXT_SIZE = 14

local function getPetNameFromEgg(eggModel)
    if not eggModel then return "Unknown" end
    for _, child in ipairs(eggModel:GetChildren()) do
        if child:IsA("Model") and not child.Name:find("HitBox") then
            return child.Name
        end
    end
    return "Unknown"
end

local function createESP(target, text)
    if target:FindFirstChild("PetESP") then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PetESP"
    billboard.Size = UDim2.new(0, 200, 0, 30)
    billboard.Adornee = target
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 3, 0)

    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = ESP_COLOR
    label.Font = FONT
    label.TextSize = TEXT_SIZE
    label.TextStrokeTransparency = 0.5

    billboard.Parent = target
end

local function isYourEgg(egg)
    return egg:GetAttribute("OWNER") == game.Players.LocalPlayer.Name
end

local function scanEggs()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:GetAttribute("OBJECT_TYPE") == "PetEgg" and isYourEgg(obj) then
            local adornee = obj:FindFirstChildWhichIsA("BasePart")
            local petName = getPetNameFromEgg(obj)
            if adornee and petName and not adornee:FindFirstChild("PetESP") then
                createESP(adornee, petName)
            end
        end
    end
end

while true do
    pcall(scanEggs)
    task.wait(2.5)
end
