-- Service
local player = game.Players.LocalPlayer
local replicatedStorage = game.ReplicatedStorage
local tweenService = game.TweenService

-- ReplicatedStorage
local frameTrigger = require(replicatedStorage.JSON.FrameTrigger)

-- Gui
local frames = player.PlayerGui:WaitForChild('Frames')
local createElevator = frames:WaitForChild('CreateElevator')
local control = createElevator:WaitForChild('Frame'):WaitForChild('Control')

local mood = control:WaitForChild('Frame'):WaitForChild('Mood')
local trigger = mood:WaitForChild('Frame'):WaitForChild('Trigger')
local onOff = mood:WaitForChild('OnOff')
local fill = mood:WaitForChild('Frame'):WaitForChild('Fill')
local endPoint = fill:WaitForChild('EndPoint')

local number = control:WaitForChild('Frame'):WaitForChild('Number')
local bonus = number:WaitForChild('Frame'):WaitForChild('Bonus')
local minus = number:WaitForChild('Frame'):WaitForChild('Minus')
local numberInRoomText = number:WaitForChild('Frame'):WaitForChild('TextLabel')
local numberInRoom = number:WaitForChild('NumberInRoom')

-- Var
local maxElevator = 3

-- NumberInRoom
bonus.MouseEnter:Connect(function()
	bonus.BackgroundTransparency = 0.5
end)
minus.MouseEnter:Connect(function()
	minus.BackgroundTransparency = 0.5
end)

bonus.MouseLeave:Connect(function()
	bonus.BackgroundTransparency = 1
end)
minus.MouseLeave:Connect(function()
	minus.BackgroundTransparency = 1
end)

bonus.MouseButton1Click:Connect(function()
	if numberInRoom.Value < maxElevator then
		numberInRoom.Value += 1
		numberInRoomText.Text = tostring(numberInRoom.Value)
	end
end)

minus.MouseButton1Click:Connect(function()
	if numberInRoom.Value > 1 then
		numberInRoom.Value -= 1
		numberInRoomText.Text = tostring(numberInRoom.Value)
	end
end)

-- Mood
trigger.MouseButton1Click:Connect(function()
	if onOff.Value == 0 then
		onOff.Value = 1
		tweenService:Create(endPoint, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.fromScale(1, 0.5)}):Play()
		endPoint.AnchorPoint = Vector2.new(1, 0.5)
		fill.BackgroundColor3 = Color3.fromRGB(230, 189, 170)
	else
		onOff.Value = 0
		tweenService:Create(endPoint, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0, 0.5)}):Play()
		endPoint.AnchorPoint = Vector2.new(0, 0.5)
		fill.BackgroundColor3 = Color3.fromRGB(83, 68, 61)
	end
end)