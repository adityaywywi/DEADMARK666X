local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local SideBar = Instance.new("Frame")
local Tabs = {}
local TabButtons = {}
local Logo = Instance.new("ImageLabel")

local tabs = {"Main", "Farm", "Shop", "Pet", "Utility", "Misc", "Visual"}

-- Parent
ScreenGui.Name = "DeadMarkUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Main Frame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Visible = true

-- Top Bar
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
TopBar.Size = UDim2.new(1, 0, 0, 30)

-- Logo
Logo.Name = "Logo"
Logo.Parent = TopBar
Logo.Size = UDim2.new(0, 24, 0, 24)
Logo.Position = UDim2.new(0, 4, 0, 3)
Logo.Image = "rbxassetid://YOUR_LOGO_ID" -- Ganti dengan ID logomu

-- Title
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 35, 0, 0)
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "DeadMark666X | GaG"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Text = "-"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

-- Sidebar
SideBar.Name = "SideBar"
SideBar.Parent = MainFrame
SideBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
SideBar.Position = UDim2.new(0, 0, 0, 30)
SideBar.Size = UDim2.new(0, 100, 1, -30)

-- Create Tabs
for i, tabName in ipairs(tabs) do
	local btn = Instance.new("TextButton")
	btn.Name = tabName .. "Button"
	btn.Parent = SideBar
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
	btn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
	btn.Text = tabName
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	
	local tabFrame = Instance.new("Frame")
	tabFrame.Name = tabName .. "Tab"
	tabFrame.Parent = MainFrame
	tabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	tabFrame.Position = UDim2.new(0, 100, 0, 30)
	tabFrame.Size = UDim2.new(1, -100, 1, -30)
	tabFrame.Visible = false
	
	btn.MouseButton1Click:Connect(function()
		for _, t in pairs(Tabs) do t.Visible = false end
		tabFrame.Visible = true
	end)
	
	TabButtons[#TabButtons + 1] = btn
	Tabs[#Tabs + 1] = tabFrame
end

-- Set first tab visible
Tabs[1].Visible = true

return {
	MainUI = ScreenGui,
	MainFrame = MainFrame,
	Tabs = Tabs
}
