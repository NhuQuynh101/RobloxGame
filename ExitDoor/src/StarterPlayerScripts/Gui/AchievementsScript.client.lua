-- Service 
local player = game.Players.LocalPlayer
local replicatedStorage = game.ReplicatedStorage
local tweenService = game.TweenService

-- ReplicatedStorage
local remotes = replicatedStorage.Remotes
local frameTrigger = require(replicatedStorage.JSON.FrameTrigger)
local achievementData = require(replicatedStorage.JSON.Achievements)

-- Gui
local frames = player.PlayerGui:WaitForChild('Frames')
local achievement = frames:WaitForChild('Achievement')
local header = achievement:WaitForChild('Frame'):WaitForChild('Header')
local scrollingFrame = achievement:WaitForChild('Frame'):WaitForChild('ScrollingFrame')
local showDetails = achievement:WaitForChild('Frame'):WaitForChild('showDetails')

-- ��ng frame
header.Close.MouseButton1Click:Connect(function()
	frameTrigger.CloseFrame('Achievement')
end)

-- Load Achievement
remotes.LoadAchievements.OnClientEvent:Connect(function()
	for _, group in pairs(player.AchievementLibrary:GetChildren()) do
		local groupFrame = scrollingFrame:WaitForChild('Group'):Clone()
		groupFrame.Parent = scrollingFrame
		groupFrame.Name = group.Name
		groupFrame.LayoutOrder = group.Order.Value
		groupFrame.Visible = true
		
		groupFrame.GroupTitle.Text = group.Name
		
		local itemHolder = groupFrame:WaitForChild('ItemHolder')
		for _, item in pairs(group:GetChildren()) do
			if item.Name ~= 'Order' then
				local itemFrame = itemHolder:WaitForChild('Item'):Clone()
				itemFrame.Parent = itemHolder
				itemFrame.Name = item.Name
				itemFrame.Visible = true
				itemFrame.ImageButton.Image = item.Image.Value
				itemFrame.ImageButton.HoverImage = item.Image.Value
				if item.Status.Value == 1 then
					itemFrame.ImageButton.Cover.Visible = false
					itemFrame.ImageButton.Interactable = true
				else
					itemFrame.ImageButton.Cover.Visible = true
					itemFrame.ImageButton.Interactable = false
				end
			end
		end
	end
end)


showDetails.TextButton.MouseEnter:Connect(function()
	tweenService:Create(showDetails.TextButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale(0.95, 0.18)}):Play()
	task.wait(0.2)
end)
showDetails.TextButton.MouseLeave:Connect(function()
	tweenService:Create(showDetails.TextButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale(1, 0.2)}):Play()
	task.wait(0.2)
end)

-- Code ch?c nang b?m v� n�t v� show detail