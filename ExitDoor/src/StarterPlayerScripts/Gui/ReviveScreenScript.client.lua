local player = game.Players.LocalPlayer
local replicatedStorage = game.ReplicatedStorage
local tweenService = game.TweenService
-- ReplicatedStorage
local remotes = replicatedStorage:WaitForChild('Remotes')

-- Gui 
local frames = player.PlayerGui:WaitForChild('Frames')
local reviveScreen = frames:WaitForChild('ReviveScreen')
local option = reviveScreen:WaitForChild('Option')
local reviveStatus = reviveScreen:WaitForChild('ReviveStatus')
local statsScreen = reviveScreen:WaitForChild('StatsScreen')
local header = statsScreen:WaitForChild('Frame'):WaitForChild('Header')
local statsScreen_Option = statsScreen:WaitForChild('Frame'):WaitForChild('Option')

-- Var
local reviveTime = 10

-- Option
option.Stats.TextButton.MouseButton1Click:Connect(function()
	statsScreen.Visible = true
end)

-- StatsScreen
header .Close.MouseButton1Click:Connect(function()
	statsScreen.Visible = false
end)

-- Remotes
remotes.Dead.OnClientEvent:Connect(function()
    tweenService:Create(reviveStatus.Notice.Frame, TweenInfo.new(reviveTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale(1, 1)}):Play()
end)


