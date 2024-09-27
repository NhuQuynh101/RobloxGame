local dataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptStorage = game:GetService('ServerScriptService')

local remotes = ReplicatedStorage.Remotes

local playerInventory = dataStoreService:GetDataStore('playerInventory')
local playerEmerals = dataStoreService:GetDataStore('playerInventory', 'Emerals')
local playerAchievement = dataStoreService:GetDataStore('playerInventory', 'Achievement')
local playerItems = dataStoreService:GetDataStore('playerInventory', 'Items')

local attributeList = {
	'Emerals',
	'Achievement',
	'EmeralsItems',
	'RobuxItems',
}

--MAIN FUNCTION
function mainfunc (player)
	local playerCharacter = workspace:WaitForChild(player.Name)

	-- function 
	loadPlayerFolder(player)
	Achievements(player)
	
	-- remotes
end

function playerDead (player)
	while task.wait(1) do
		local character = workspace:WaitForChild(player.Name)
		
		if character.Humanoid.Health == 0 then
			local t = true
			coroutine.wrap(resetCharacter)(t, player)
		end
	end
end

function resetCharacter(t, player)
	wait(1)
	while t == true do
		local playerCharacter = workspace:WaitForChild(player.Name)
		if playerCharacter.Humanoid.Health == 100 then
			task.wait(0.5)
			mainfunc(player)
			t = false
		end
		task.wait(0.5)
	end
end

-- load player folder
function loadPlayerFolder(player)
	local playerData = ReplicatedStorage:WaitForChild('PlayerData')
	
	for _, folder in pairs(playerData:GetChildren()) do
		local newFolder = folder:Clone()
		newFolder.Parent = player
	end
	print("LoadPlayerFolder")
end

-- Get Emerals
function getEmerals (player)
	local success, currentEmerals = pcall(function()
		return playerEmerals:GetAsync(player.UserID)
	end)

	if playerEmerals ~= nil then
		player.Emerals.Value = currentEmerals
	else
		playerEmerals:SetAsync(player.UserID, 0)
		player.Emerals.Value = 0
	end
	remotes.UpdateEmerals:FireClient(player)
end

--Get Achievements
function Achievements(player)
	local AchievementsData = require(ReplicatedStorage.JSON.Achievements)
	local success, currentAchievements = pcall(function()
		return playerAchievement:GetAsync(player.UserId)
	end)
	
	if success then
		if currentAchievements ~= nil then
			for _, achievement in pairs(AchievementsData) do
				if achievement.name then
					if currentAchievements[achievement.name] == nil then
						currentAchievements[achievement.name] = achievement
					end
				end
			end
			playerAchievement:SetAsync(player.UserId, currentAchievements)
			print(currentAchievements)
			updateAchievementsClient(player,currentAchievements)
		else
			playerAchievement:SetAsync(player.UserId, AchievementsData)
			print(AchievementsData)
			updateAchievementsClient(player,AchievementsData)
		end
		print("Achievements")
	end
end

function updateAchievementsClient(player, AchievementsData)
	print(AchievementsData)
	for _, achievementType in pairs(AchievementsData) do
		local typeFolder = Instance.new('Folder')
		typeFolder.Parent = player.AchievementLibrary
		typeFolder.Name = achievementType.groupName
		
		local orderNum = Instance.new('IntValue')
		orderNum.Parent = typeFolder
		orderNum.Name = 'Order'
		orderNum.Value = achievementType.order
		
		for _, achievement in pairs(achievementType) do
			print(achievement)
			if achievement ~= achievementType.groupName and achievement ~= achievementType.order then
				local badge = Instance.new('StringValue')
				badge.Name = tostring(achievement.name)
				badge.Parent = typeFolder

				local order = Instance.new('IntValue')
				order.Name = 'Order'
				order.Value = achievement.order
				order.Parent = badge

				local status = Instance.new('IntValue')
				status.Name = 'Status'
				status.Value = achievement.status
				status.Parent = badge

				local showName = Instance.new('StringValue')
				showName.Name = 'ShowName'
				showName.Value = achievement.showName
				showName.Parent = badge

				local explanation = Instance.new('StringValue')
				explanation.Name = 'Explanation'
				explanation.Value = achievement.explaination
				explanation.Parent = badge

				local description = Instance.new('StringValue')
				description.Name = 'Description'
				description.Value = achievement.description
				description.Parent = badge

				local image = Instance.new('StringValue')
				image.Name = 'Image'
				image.Value = achievement.image
				image.Parent = badge
			end

			print("a")
		end
	end
	
	remotes.LoadAchievements:FireClient(player)
	print("loaded")
end



---------------------------------------------------------------------------
---------------------------------------------------------------------------
-- REMOTES
remotes.EmeralsPurchase.OnServerEvent:Connect(function(player, price, itemList)
	local success, updatedEmerals = pcall(function()
		return playerEmerals:IncrementAsync(player.UserId, (-1) * price)
	end)
	if success then
		player.Emerals.Value = updatedEmerals
		-- Code ph?n update items
	end
end)

---------------------------------------------------------------------------
---------------------------------------------------------------------------
game.Players.PlayerAdded:Connect(mainfunc)
