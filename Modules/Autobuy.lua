-- ✅ modules/AutoBuy.lua -- Fungsi untuk auto-beli seed dari shop Grow a Garden

return function(config) local ReplicatedStorage = game:GetService("ReplicatedStorage")

local selectedSeeds = config.selectedSeeds or {}
local interval = config.interval or 5

local function getBuyRemote()
    local gameEvents = ReplicatedStorage:FindFirstChild("GameEvents")
    return gameEvents and gameEvents:FindFirstChild("BuySeedStock")
end

local function findHarvestShop()
    local interaction = workspace:FindFirstChild("Interaction")
    local updateItems = interaction and interaction:FindFirstChild("Updateltems")
    return updateItems and updateItems:FindFirstChild("HarvestShop")
end

task.spawn(function()
    while true do
        local shop = findHarvestShop()
        local buyRemote = getBuyRemote()

        if shop and buyRemote then
            for _, item in pairs(shop:GetChildren()) do
                if selectedSeeds[item.Name] and item:FindFirstChild("Stock") and item.Stock.Value > 0 then
                    buyRemote:FireServer(item.Name, 1)
                    print("[AUTO BUY] Bought:", item.Name)
                    task.wait(0.5)
                end
            end
        else
            warn("[AUTO BUY] Shop or Remote not found")
        end

        task.wait(interval)
    end
end)

end

