-- gag.lua
-- ✅ Loader utama untuk semua module di DEADMARK666X

-- Lokasi folder modules
local MODULE_PATH = "Deadmark.Modules"

-- Fungsi bantu untuk load module dengan aman
local function safeRequire(moduleName)
    local success, module = pcall(function()
        return require(script:FindFirstChild(moduleName) or game:GetService("ReplicatedStorage"):WaitForChild(MODULE_PATH):WaitForChild(moduleName))
    end)
    if success then
        task.spawn(module.run) -- pastikan module punya fungsi run()
    else
        warn("[GAG] Gagal memuat module:", moduleName, module)
    end
end

-- Daftar module yang ingin dijalankan
local modules = {
    "Autobuy", -- ✅ Modul auto-buy seed
    "Ui",      -- ✅ Modul UI (jika ada UI terpisah)
    -- Tambahkan lagi module jika perlu seperti "ESP", "AutoCollect", dll.
}

-- Jalankan semua module
for _, modName in ipairs(modules) do
    safeRequire(modName)
end

print("[GAG] Semua module dimuat")
