-- Service
local player = game.Players.LocalPlayer
local tweenService = game.TweenService
local replicatedStorage = game.ReplicatedStorage

-- Gui 
local frames = player.PlayerGui:WaitForChild('Frames')
local shop = frames:WaitForChild('Store')
local header = shop:WaitForChild('Frame'):WaitForChild('Frame'):WaitForChild('Header')
local option1 = shop:WaitForChild('Frame'):WaitForChild('Frame'):WaitForChild('Option1')
local option2 = shop:WaitForChild('Frame'):WaitForChild('Frame'):WaitForChild('Option2')

-- ReplicatedStorage
local frameTrigger = require(replicatedStorage.JSON:WaitForChild('FrameTrigger'))

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