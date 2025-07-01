local supportedGames = {
    [7436755782] = "https://raw.githubusercontent.com/USERNAME/REPO/main/gag.lua", -- Grow a Garden
}

local gameId = game.GameId
if supportedGames[gameId] then
    local source = game:HttpGet(supportedGames[gameId])
    loadstring(source)()
end
