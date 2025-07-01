local a
local folderName = "my_script_cache"
local fileName = folderName.."/gag.lua"
pcall(function() a = readfile(fileName) end)

if a and #a > 1000 then -- cek apakah file valid
    a = loadstring(a)
end

if a then
    return a()
else
    pcall(makefolder, folderName)
    a = game:HttpGet("https://raw.githubusercontent.com/adityaywywi/DEADMARK666X/main/gag.lua")
    writefile(fileName, a)
    loadstring(a)()
end
