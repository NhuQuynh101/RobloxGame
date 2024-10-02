local player = game.Players.LocalPlayer
local replicatedStorage = game.ReplicatedStorage

-- ReplicatedStorage
local remotes = replicatedStorage:WaitForChild('Remotes')

local json = replicatedStorage:WaitForChild('JSON')

-- Gui 
local frames = player.PlayerGui:WaitForChild('Frames')
local hotBar = frames:WaitForChild('Hotbar')

remotes.LoadItem.OnClientEvent:Connect(function(item)
    for _, item in pairs(player:WaitForChild('EmeralsItems'):GetChildren()) do
        if item.quanity.Value > 0 then
            local btn = hotBar:WaitForChild('Template'):Clone()
            btn.Visible = true
            --btn.Tool.Image = item.image
            btn.DurabilityNumber.Text = tostring('x'..item.quanity.Value)
            btn.Durability.Bar.Size = UDim2.fromScale(1, 1)
            btn.Name = item.name
            btn.Parent = hotBar
            btn.SlotNum.Text = tostring(item.order.Value)
        end
    end  
end)
