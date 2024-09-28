-- Service
local player = game.Players.LocalPlayer
local replicatedStorage = game.ReplicatedStorage

-- ReplicatedStorage 
local remotes = replicatedStorage:WaitForChild('Remotes')
local json = replicatedStorage:WaitForChild('JSON')
local emeralsItem = require(json.EmeralsItems)

-- Gui 
local frames = player.PlayerGui:WaitForChild('Frames')
local preRunStore = frames:WaitForChild('PreRunStore')
local option1 = preRunStore:WaitForChild('Frame'):WaitForChild('Frame'):WaitForChild('Option'):WaitForChild('Option1')
local option2 = preRunStore:WaitForChild('Frame'):WaitForChild('Frame'):WaitForChild('Option'):WaitForChild('Option2')
local option4 = preRunStore:WaitForChild('Frame'):WaitForChild('Frame'):WaitForChild('Option'):WaitForChild('Option4')
local price = preRunStore:WaitForChild('Frame'):WaitForChild('Frame'):WaitForChild('Option'):WaitForChild('Price')
local showEmerals = preRunStore:WaitForChild('Frame'):WaitForChild('Frame'):WaitForChild('Header'):WaitForChild('Frame'):WaitForChild('Emerals')
local confirmButton = option4:WaitForChild('Button')

-- Var 
local itemList = {}

for _, item in pairs(option1:GetChildren()) do
	if item:IsA('Frame') then
		if item:FindFirstChild('Buy') then
			item.Buy.MouseButton1Click:Connect(function()
				if item.Chosen.Value == 1 then
					item.UIStroke.Thickness = 2
					item.BackgroundColor3 = Color3.fromRGB(58, 29, 0)
					item.Chosen.Value = 0
					price.Value -= emeralsItem[item.Name].price
					table.remove(itemList, item.Name)
				else
					item.UIStroke.Thickness = 4
					item.BackgroundColor3 = Color3.fromRGB(255, 128, 0)
					item.Chosen.Value = 1
					price.Value += emeralsItem[item.Name].price
					itemList[item.Name] = item.Name
				end
				if price.Value > 0 then
					option4.Confirm.Frame.Visible = true
					option4.Confirm.Frame.Price.Text = tostring(price.Value)
				else
					option4.Confirm.Frame.Visible = false
				end
			end)
		end
	end
end

for _, item in pairs(option2:GetChildren()) do
	if item:IsA('Frame') then
		if item:FindFirstChild('Buy') then
			item.Buy.MouseButton1Click:Connect(function()
				if item.Chosen.Value == 1 then
					item.UIStroke.Thickness = 2
					item.BackgroundColor3 = Color3.fromRGB(58, 29, 0)
					item.Chosen.Value = 0
					price.Value -= emeralsItem[item.Name].price
					table.remove(itemList, item.Name)
				else
					item.UIStroke.Thickness = 4
					item.BackgroundColor3 = Color3.fromRGB(255, 128, 0)
					item.Chosen.Value = 1
					price.Value += emeralsItem[item.Name].price
					itemList[item.Name] = item.Name
				end
				print(itemList)
				if price.Value > 0 then
					option4.Confirm.Frame.Visible = true
					option4.Confirm.Frame.Price.Text = tostring(price.Value)
				else
					option4.Confirm.Frame.Visible = false
				end
			end)
		end
	end
end

confirmButton.MouseButton1Click:Connect(function()
	if price.Value > 0 then
		if player.Emerals.Value >= price.Value then
			remotes.EmeralsPurchase:FireServer(price.Value, itemList)
			table.clear(itemList)
		end
	end
end)

---------------------------------------------------------------
---------------------------------------------------------------
-- Remotes

remotes.UpdateEmerals.OnClientEvent:Connect(function()
	showEmerals:WaitForChild('Text1').Text = tostring(player.Emerals.Value)
end)