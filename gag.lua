-- ✅ GROW A GARDEN - DEADMARK666X FULL SCRIPT

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- === CONFIG ===
local summerFruits = { "Watermelon", "Mango", "Pineapple", "Lime" }

-- === FUNCTIONS ===

-- 🔁 Auto-buy Seed
task.spawn(function()
    while true do
        local inv = LocalPlayer:FindFirstChild("Backpack") or LocalPlayer:FindFirstChild("backpack")
        local hasSeed = false

        if inv then
            for _, item in ipairs(inv:GetChildren()) do
                if item.Name:lower():find("seed") then
                    hasSeed = true
                    break
                end
            end
        end

        if not hasSeed then
            local buySeed = ReplicatedStorage:FindFirstChild("BuySeed")
            if buySeed then
                buySeed:FireServer()
                warn("[AUTO SEED] Seed purchased.")
            end
        end
        task.wait(3)
    end
end)

-- 🍓 Auto Collect Fruits
task.spawn(function()
    while true do
        local collectEvent = ReplicatedStorage:FindFirstChild("CollectAll")
        if collectEvent then
            collectEvent:FireServer()
            warn("[AUTO COLLECT] All fruits collected.")
        end
        task.wait(5)
    end
end)

-- ☀️ Auto Submit Summer Fruits
task.spawn(function()
    while true do
        local fruitFolder = LocalPlayer:FindFirstChild("Fruits")
        if fruitFolder then
            for _, fruit in ipairs(fruitFolder:GetChildren()) do
                if table.find(summerFruits, fruit.Name) then
                    ReplicatedStorage.SubmitFruit:FireServer(fruit)
                    warn("[AUTO SUBMIT] Summer fruit submitted:", fruit.Name)
                end
            end
        end
        task.wait(4)
    end
end)
