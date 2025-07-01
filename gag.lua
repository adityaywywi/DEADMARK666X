for _, egg in ipairs(workspace:GetDescendants()) do
    if egg:IsA("Model") and egg:GetAttribute("OBJECT_TYPE") == "PetEgg" then
        local owner = egg:GetAttribute("OWNER")
        if owner == game.Players.LocalPlayer.Name then
            print("====== Your Egg ======")
            print("Egg Name: " .. (egg:GetAttribute("EggName") or "Unknown"))

            for _, child in ipairs(egg:GetChildren()) do
                if child:IsA("Model") then
                    print("Model: " .. child.Name)
                    for _, subModel in ipairs(child:GetChildren()) do
                        if subModel:IsA("Model") then
                            print(" + Sub-model: " .. subModel.Name)
                        elseif subModel:IsA("Part") then
                            print(" + Part: " .. subModel.Name)
                        end
                    end
                elseif child:IsA("Part") then
                    print("Part: " .. child.Name)
                elseif child:IsA("ProximityPrompt") then
                    print("Prompt: " .. child.Name)
                end
            end

            print("======================")
        end
    end
end
