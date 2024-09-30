-- Service
local player = game.Players.LocalPlayer
local tweenService = game:GetService("TweenService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

-- Gui 
local frames = player.PlayerGui:WaitForChild('Frames')
local shop = frames:WaitForChild('Store')
local header = shop:WaitForChild('Frame'):WaitForChild('Frame'):WaitForChild('Header')
local option1 = shop:WaitForChild('Frame'):WaitForChild('Frame'):WaitForChild('Option1')
local option2 = shop:WaitForChild('Frame'):WaitForChild('Frame'):WaitForChild('Option2')
local gold = option1:WaitForChild('Gold')
local revive = option1:WaitForChild('Revive')
local boost = option1:WaitForChild('3Boosts')

-- ReplicatedStorage
local remotes = replicatedStorage.Remotes
local frameTrigger = require(replicatedStorage.JSON:WaitForChild('FrameTrigger'))
local robuxItems = require(replicatedStorage.JSON:WaitForChild('RobuxItems'))

--header.ChangeOption.MouseButton1Click:Connect(function()
--	if header.ChangeOption.OnScreen.Value == 'Option1' then
--		header.ChangeOption.Text = 'Back'
--		header.ChangeOption.OnScreen.Value = 'Option2'
--		option2.Visible = true
--		tweenService:Create(option2, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale(1, 0.86)}):Play()
--		tweenService:Create(option1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale(0, 0)}):Play()
--		task.wait(0.2)
--		option1.Visible = false

--	else
--		header.ChangeOption.Text = 'UGC'
--		header.ChangeOption.OnScreen.Value = 'Option1'
--		option1.Visible = true
--		tweenService:Create(option1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale(1, 0.9)}):Play()
--		tweenService:Create(option2, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale(0, 0)}):Play()
--		task.wait(0.2)
--		option2.Visible = false
--	end
--end)

header.Close.MouseButton1Click:Connect(function()
	frameTrigger.CloseFrame('Store')
end)

-- New function to handle selling items by Robux
local function sellByRobux(itemId)
    local item = robuxItems[itemId]
    if item then
        local success, errorMessage = pcall(function()
			MarketplaceService:PromptProductPurchase(player, item.productId)
		end)

		if not success then
			warn("Failed to prompt purchase:", errorMessage)
		else
			local playerId = player.UserId
			local productId = item.productId
			local success, errormessage = pcall(function()
				MarketplaceService.PromptProductPurchaseFinished:Connect(function(playerId, productId, IsPurchased)
					if IsPurchased == true then
					onPurchaseSuccess(itemId)
				end
				end)
			end)
			if not success then
				warn("Failed to connect to PromptProductPurchaseFinished:", errormessage)
			end
		end
    end
end

-- Function to handle successful purchases
function onPurchaseSuccess(itemId)
	-- Call the server function to update the player's inventory
	local success = remotes.UpdateRobuxItems:InvokeServer(itemId)
            
    if success then
        print("Inventory updated successfully for item:", itemId)
        -- You might want to update the client-side UI here to reflect the new inventory
    else
        warn("Failed to update inventory for item:", itemId)
    end
end

-- Buy
boost.Buy.MouseButton1Click:Connect(function()
	sellByRobux('3Boosts')
end)
for _, item in pairs(gold:GetChildren()) do
	if item:IsA('Frame') then
		item.Buy.MouseButton1Click:Connect(function()
			sellByRobux(item.Name)
		end)
	end
end
revive.Buy.MouseButton1Click:Connect(function()
	sellByRobux('Revive')
end)
