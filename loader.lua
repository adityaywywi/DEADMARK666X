for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("Part") and v.Name:lower():find("egg") then
        local bb = Instance.new("BillboardGui", v)
        bb.Name = "ESP"
        bb.Adornee = v
        bb.Size = UDim2.new(0, 100, 0, 20)
        bb.StudsOffset = Vector3.new(0, 2, 0)
        bb.AlwaysOnTop = true

        local label = Instance.new("TextLabel", bb)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = v.Name
        label.TextColor3 = Color3.new(1, 1, 0)
        label.TextScaled = true
        label.Font = Enum.Font.SourceSansBold
    end
end
