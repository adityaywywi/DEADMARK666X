local EggContents = {
    ["Common Egg"] = {"Golden Lab", "Dog", "Bunny"},
    ["Uncommon Egg"] = {"Black Bunny", "Cat", "Chicken", "Deer"},
    ["Rare Egg"] = {"Orange Tabby", "Spotted Deer", "Pig", "Rooster", "Monkey"},
    ["Legendary Egg"] = {"Cow", "Silver Monkey", "Sea Otter", "Polar Bear", "Turtle"},
    ["Mythical Egg"] = {"Grey Mouse", "Brown Mouse", "Squirrel", "Red Giant Ant", "Red Fox"},
    ["Common Summer Egg"] = {"Starfish", "Seagull", "Crab"},
    ["Rare Summer Egg"] = {"Flamingo", "Toucan", "Sea Turtle", "Orangutan", "Seal"},
    ["Paradise Egg"] = {"Ostrich", "Peacock", "Capybara", "Scarlet Macaw", "Mimic Octopus"},
    ["Night Egg"] = {"Hedgehog", "Kiwi", "Mole", "Echo Frog", "Night Owl"}, 
}

for _, egg in pairs(workspace:GetDescendants()) do
    if egg:IsA("Part") and EggContents[egg.Name] and not egg:FindFirstChild("ESPLabel") then
        local gui = Instance.new("BillboardGui", egg)
        gui.Name = "ESPLabel"
        gui.Adornee = egg
        gui.Size = UDim2.new(0, 150, 0, 40)
        gui.StudsOffset = Vector3.new(0, 2, 0)
        gui.AlwaysOnTop = true

        local label = Instance.new("TextLabel", gui)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(0, 255, 0)
        label.TextScaled = true
        label.Font = Enum.Font.SourceSansBold
        label.Text = table.concat(EggContents[egg.Name], ", ")
    end
end
