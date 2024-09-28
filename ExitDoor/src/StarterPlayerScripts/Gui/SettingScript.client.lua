-- Service
local player = game.Players.LocalPlayer
local tweenService = game.TweenService
local replicatedStorage = game.ReplicatedStorage
local mouse = player:GetMouse()

-- ReplicatedStorage
local frameTrigger = require(replicatedStorage.JSON:WaitForChild('FrameTrigger'))

-- Gui 
local frames = player.PlayerGui:WaitForChild('Frames')
local setting = frames:WaitForChild('Setting')
local header = setting:WaitForChild('Frame'):WaitForChild('Header')
local options = setting:WaitForChild('Frame'):WaitForChild('Options')
local music = options:WaitForChild('Music')
local sound = options:WaitForChild('Sound')


header.Close.MouseButton1Click:Connect(function()
	frameTrigger.CloseFrame('Setting')
end)

-- Music 
local musicVolumeBar = music:WaitForChild('VolumeBar')
local musicFill = musicVolumeBar:WaitForChild('Fill')
local musicTrigger = musicVolumeBar:WaitForChild('Trigger')

musicFill.Size = UDim2.fromScale(1, 1)

function updateMusicVolume()
	local output = (mouse.X - musicVolumeBar.AbsolutePosition.X) / musicVolumeBar.AbsoluteSize.X
	if 0 < output and output <= 1 then
		musicFill.Size = UDim2.fromScale(output , 1)
		-- Add music
	end
end

local sliderMusicActive = false

function ActivateMusicSlider()
	sliderMusicActive = true
	while sliderMusicActive do
		updateMusicVolume()
		task.wait()
	end
end

musicTrigger.MouseButton1Down:Connect(ActivateMusicSlider)

game:GetService('UserInputService').InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		sliderMusicActive = false
	end
end)

-- Sound
local soundVolumeBar = sound:WaitForChild('VolumeBar')
local soundFill = soundVolumeBar:WaitForChild('Fill')
local soundTrigger = soundVolumeBar:WaitForChild('Trigger')

soundFill.Size = UDim2.fromScale(1, 1)

function updateSoundVolume()
	local output = (mouse.X - soundVolumeBar.AbsolutePosition.X) / soundVolumeBar.AbsoluteSize.X
	if 0 < output and output <= 1 then
		soundFill.Size = UDim2.fromScale(output , 1)
		-- Add music
	end
end

local sliderSoundActive = false

function ActivateSoundSlider()
	sliderSoundActive = true
	while sliderSoundActive do
		updateSoundVolume()
		task.wait()
	end
end

soundTrigger.MouseButton1Down:Connect(ActivateSoundSlider)

game:GetService('UserInputService').InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		sliderSoundActive = false
	end
end)