-- gag.lua - Script utama

-- Load UI local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/adityaywywi/DEADMARK66X/main/ui.lua"))()

-- Load Modules local autobuy = loadstring(game:HttpGet("https://raw.githubusercontent.com/adityaywywi/DEADMARK66X/main/modules/autobuy.lua"))() local autosell = loadstring(game:HttpGet("https://raw.githubusercontent.com/adityaywywi/DEADMARK66X/main/modules/autosell.lua"))() local autoseed = loadstring(game:HttpGet("https://raw.githubusercontent.com/adityaywywi/DEADMARK66X/main/modules/autoseed.lua"))()

-- Tab shortcut local shopTab = ui.Tabs[3] -- "Shop" tab local farmTab = ui.Tabs[2] -- "Farm" tab

-- AUTO BUY CHECKLIST UI local seeds = { "Carrot Seed", "Strawberry Seed", "Blueberry Seed", "Tomato Seed", "Cauliflower Seed", "Watermelonr Seed", "Rafflesia Seed", "Green Apple Seed", "Avocado Seed", "Banana Seed", "Pineapple Seed", "Kiwi Seed", "Bell Pepper Seed", "Prickly Pear Seed", "Loquat Seed", "Feijoa Seed", "Pitcher Plant", "Sugar Apple Seed" }

local selected = {}

for i, seedName in ipairs(seeds) do local cb = Instance.new("TextButton") cb.Size = UDim2.new(0, 180, 0, 25) cb.Position = UDim2.new(0, 10, 0, 10 + (i-1) * 30) cb.BackgroundColor3 = Color3.fromRGB(80, 0, 0) cb.Text = "[ ] " .. seedName cb.TextColor3 = Color3.new(1, 1, 1) cb.Font = Enum.Font.Gotham cb.TextSize = 14 cb.Parent = shopTab

cb.MouseButton1Click:Connect(function()
    selected[seedName] = not selected[seedName]
    cb.Text = selected[seedName] and "[✓] " .. seedName or "[ ] " .. seedName
end)

end

-- Loop Auto-Buy spawn(function() while true do pcall(function() for seed, on in pairs(selected) do if on then autobuy.BuySeed(seed) end end end) task.wait(2) end end)

print("🔥 DeadMark666X Loaded!")

