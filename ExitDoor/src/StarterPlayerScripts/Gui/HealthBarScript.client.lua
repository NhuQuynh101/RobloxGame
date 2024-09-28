local StarterGui = game:GetService("StarterGui")
local player = game.Players.LocalPlayer

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)

local function updateHealth(humanoid)
	local healthBar = player.PlayerGui:WaitForChild('HealthBarGui'):WaitForChild("HealthBarBackground"):WaitForChild("HealthBar")

	local function onHealthChanged()
		local health = humanoid.Health
		local maxHealth = humanoid.MaxHealth
		local healthPercentage = health / maxHealth
		healthBar.Size = UDim2.new(healthPercentage, 0, 1, 0)
	end

	humanoid.HealthChanged:Connect(onHealthChanged)
	onHealthChanged()
end

player.CharacterAdded:Connect(function(character)
	local humanoid = character:WaitForChild("Humanoid")
	updateHealth(humanoid)
end)

if player.Character then
	local humanoid = player.Character:FindFirstChild("Humanoid")
	if humanoid then
		updateHealth(humanoid)
	end
end
