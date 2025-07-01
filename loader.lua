for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") and string.find(obj.Name:lower(), "egg") then
        print("🔍 Egg Found:", obj.Name)
    end
end
