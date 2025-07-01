local supportedGames = {
    [7436755782] = "https://raw.githubusercontent.com/adityaywywi/DEADMARK666X/main/gag.lua" -- Grow a Garden
}

local gameNames = {
    [7436755782] = "Grow a Garden"
}

local gameId = game.GameId

if supportedGames[gameId] then
    game.StarterGui:SetCore("SendNotification", {
        Title = "DEADMARK666X",
        Text = "Loaded for " .. (gameNames[gameId] or "Your Game"),
        Duration = 5
    })

    local url = supportedGames[gameId]
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)

    if success then
        loadstring(result)()
    else
        warn("[DEADMARK666X] Failed to load script: " .. tostring(result))
    end
else
    game.StarterGui:SetCore("SendNotification", {
        Title = "DEADMARK666X",
        Text = "Unsupported Game",
        Duration = 5
    })
end
