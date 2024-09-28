local player = game.Players.LocalPlayer
local tweenService = game.TweenService

local warningScreen = player.PlayerGui:WaitForChild('Frames'):WaitForChild('WarningScreen')
local screenTap = warningScreen:WaitForChild('ScreenTap')
local warnIcon = warningScreen:WaitForChild('Frame'):WaitForChild('WarnIcon')
local redText = warningScreen:WaitForChild('Frame'):WaitForChild('RedText')
local whiteText = warningScreen:WaitForChild('Frame'):WaitForChild('WhiteText')
local yellowText = warningScreen:WaitForChild('Frame'):WaitForChild('YellowText')
local textButton = warningScreen:WaitForChild('Frame'):WaitForChild('TextButton')

screenTap.MouseButton1Click:Connect(function()
	tweenService:Create(warnIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.5, -0.1)}):Play()
	tweenService:Create(yellowText, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.5, 0.15)}):Play()
	tweenService:Create(whiteText, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.5, 0.4)}):Play()
	tweenService:Create(redText, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.5, 0.65)}):Play()
	textButton.Visible = true
	screenTap.Visible = false
end)

textButton.MouseButton1Click:Connect(function()
	tweenService:Create(warnIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
	tweenService:Create(yellowText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
	tweenService:Create(whiteText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
	tweenService:Create(redText, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
	tweenService:Create(textButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
	task.wait(0.1)
	tweenService:Create(warningScreen, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1, Size = UDim2.fromScale(0, 0)}):Play()
	task.wait(0.2)
	warningScreen.Visible = false
end)