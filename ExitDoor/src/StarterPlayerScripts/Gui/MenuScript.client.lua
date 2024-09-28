-- Service
local player = game.Players.LocalPlayer
local tweenService = game.TweenService
local replicatedStorage = game.ReplicatedStorage

-- Gui
local menu = player.PlayerGui:WaitForChild('Menu')
local frames = player.PlayerGui:WaitForChild('Frames')
local frame = menu:WaitForChild('Frame')

-- ReplicatedStorage
local frameTrigger = require(replicatedStorage.JSON:WaitForChild('FrameTrigger'))

for _, frame in pairs(frame:GetChildren()) do
	if frame:IsA('Frame') then
		frame.ImageButton.MouseEnter:Connect(function()
			frame.BackgroundColor3 = Color3.fromRGB(248, 219, 200)
			frame.BackgroundTransparency = 0
			frame.ImageButton.ImageColor3 = Color3.fromRGB(27, 6, 0)
			frame.TextButton.Visible = true
			frame.TextButton.AutomaticSize = Enum.AutomaticSize.X
		end)
		
		frame.ImageButton.MouseLeave:Connect(function()
			frame.TextButton.AutomaticSize = Enum.AutomaticSize.None
			tweenService:Create(frame.TextButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale(0, 1)}):Play()
			frame.TextButton.Visible = false
			frame.BackgroundColor3 = Color3.fromRGB(27, 6, 0)
			frame.BackgroundTransparency = 0.5
			frame.ImageButton.ImageColor3 = Color3.fromRGB(248, 219, 200)
		end)
		
		frame.ImageButton.MouseButton1Click:Connect(function()
			if frames:FindFirstChild(frame.Name) then
				frameTrigger.OpenFrame(frame.Name)
			end
		end)
		frame.TextButton.MouseButton1Click:Connect(function()
			if frames:FindFirstChild(frame.Name) then
				frameTrigger.OpenFrame(frame.Name)
			end		
		end)
	end	
end