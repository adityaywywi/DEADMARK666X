local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

function CreateESP(part, petName)
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Adornee = part
    BillboardGui.Size = UDim2.new(0, 200, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true

    local TextLabel = Instance.new("TextLabel", BillboardGui)
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Text = petName
    TextLabel.TextColor3 = Color3.new(1, 1, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextScaled = true

    BillboardGui.Parent = part
end

for _, egg in ipairs(workspace:GetDescendants()) do
    if egg:IsA("Model") and egg:GetAttribute("OBJECT_TYPE") == "PetEgg" then
        local owner = egg:GetAttribute("OWNER")
        if owner == localPlayer.Name then
            local petName = nil

            for _, child in ipairs(egg:GetChildren()) do
                if child:IsA("Model") and child.Name ~= egg.Name then
                    -- Cari sub-model yang berbeda nama dari model utama (biasanya itu pet)
                    petName = child.Name
                    break
                end
            end

            if petName and egg:FindFirstChild("PetEgg") then
                CreateESP(egg.PetEgg, petName)
                print("[ESP
