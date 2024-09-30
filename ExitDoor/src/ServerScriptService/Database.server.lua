local dataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptStorage = game:GetService('ServerScriptService')

local remotes = ReplicatedStorage.Remotes

local playerInventory = dataStoreService:GetDataStore('playerInventory')
local playerEmerals = dataStoreService:GetDataStore('playerInventory', 'Emerals')
local playerAchievement = dataStoreService:GetDataStore('playerInventory', 'Achievement')
local playerEmeralsItems = dataStoreService:GetDataStore('playerInventory', 'EmeralsItems')
local playerRevive = dataStoreService:GetDataStore('playerInventory', 'Revive')
local playerBoost = dataStoreService:GetDataStore('playerInventory', 'Boost')

local attributeList = {
	'Emerals',
	'Achievement',
	'EmeralsItems',
	'Revive',
	'Boost',
}

--MAIN FUNCTION
function mainfunc (player)
	local playerCharacter = workspace:WaitForChild(player.Name)

	-- function 
	loadPlayerFolder(player)
	getEmerals(player)
	Achievements(player)
	EmeralsItems(player)

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
end

-- Get Emerals
function getEmerals (player)
	local success, currentEmerals = pcall(function()
		return playerEmerals:GetAsync(player.UserId)
	end)
	if success then
		if currentEmerals ~= nil then
			player.Emerals.Value = currentEmerals
		else
			playerEmerals:SetAsync(player.UserId, 0)
			player.Emerals.Value = 0
		end
	end
	remotes.UpdateEmerals:FireClient(player)
	print('Updated Emerals')
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
			updateAchievementsClient(player,currentAchievements)
		else
			playerAchievement:SetAsync(player.UserId, AchievementsData)
			updateAchievementsClient(player,AchievementsData)
		end
	end
end

function updateAchievementsClient(player, AchievementsData)
	for _, achievementType in pairs(AchievementsData) do
		local typeFolder = Instance.new('Folder')
		typeFolder.Parent = player.AchievementLibrary
		typeFolder.Name = achievementType.groupName
		
		local orderNum = Instance.new('IntValue')
		orderNum.Parent = typeFolder
		orderNum.Name = 'Order'
		orderNum.Value = achievementType.order
		
		for _, achievement in pairs(achievementType) do
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

		end
	end
	
	remotes.LoadAchievements:FireClient(player)
	print("loaded")
end

--Get EmeralsItems
function EmeralsItems(player)
	local EmeralsItemsData = require(ReplicatedStorage.JSON.EmeralsItems)
	local success, currentEmeralsItems = pcall(function()
		return playerEmeralsItems:GetAsync(player.UserId)
	end)
	
	if success then
		if currentEmeralsItems ~= nil then
			for _, emeralsItem in pairs(EmeralsItemsData) do
				if emeralsItem.name then
					if currentEmeralsItems[emeralsItem.name] == nil then
						currentEmeralsItems[emeralsItem.name] = emeralsItem
					end
				end
			end

			playerEmeralsItems:SetAsync(player.UserId, currentEmeralsItems)
			updateEmeralsItemsClient(player,currentEmeralsItems)
		else
			playerEmeralsItems:SetAsync(player.UserId, EmeralsItemsData)
			updateEmeralsItemsClient(player, EmeralsItemsData)
		end
	end
end

-- 
function updateEmeralsItemsClient(player, EmeralsItemsData)
	for _, emeralsItem in pairs(EmeralsItemsData) do
		local itemVar = Instance.new('StringValue')
		itemVar.Name = emeralsItem.name
		itemVar.Parent = player.EmeralsItems

		local price = Instance.new('IntValue')
		price.Name = 'price'
		price.Value = emeralsItem.price
		price.Parent = itemVar

		local description = Instance.new('StringValue')
		description.Name = 'description'
		description.Value = emeralsItem.description
		description.Parent = itemVar

		local order = Instance.new('IntValue')
		order.Name = 'order'
		order.Value = emeralsItem.order
		order.Parent = itemVar

		local quanity = Instance.new('IntValue')
		quanity.Name = 'quanity'
		quanity.Value = emeralsItem.quanity
		quanity.Parent = itemVar
	end
	
	print("Emeral Items loaded!")
end

-- Get Revive
function revive(player)
	local success, currentRevive = pcall(function()
		return playerRevive:GetAsync(player.UserId)
	end)
	if success then
		if currentRevive ~= nil then
			player.Revive.Value = currentRevive
		else
			playerRevive:SetAsync(player.UserId, 0)
			player.Revive.Value = 0
		end
	end
end

-- Get Boost
function boost(player)
	local success, currentBoost = pcall(function()
		return playerBoost:GetAsync(player.UserId)
	end)
	if success then
		if currentBoost ~= nil then
			player.Boost.Value = currentBoost
		else
			playerBoost:SetAsync(player.UserId, 0)
			player.Boost.Value = 0
		end
	end
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
		local success, currentEmeralsItems = pcall(function()
			return playerEmeralsItems:GetAsync(player.UserId)			
		end)
		if success then
			for _, item in pairs(itemList) do
				currentEmeralsItems[item].quanity += 1
			end
			local success, error = pcall(function()
				playerEmeralsItems:SetAsync(player.UserId, currentEmeralsItems)
			end)
			if success then
				for _, item in pairs(currentEmeralsItems) do
					player:WaitForChild('EmeralsItems'):WaitForChild(item.name).quanity.Value = item.quanity				
				end
				print('Saved Purchased Items')
			end
			remotes.UpdateEmerals:FireClient(player)
			remotes.LoadItem:FireClient(player)
		end
	end
end)

remotes.UpdateRobuxItems.OnServerInvoke = function(player, itemId)
	local robuxItemsData = require(ReplicatedStorage.JSON.RobuxItems)
		if itemId == 'Revive' then
			local success, updatedRevive = pcall(function()
				return playerRevive:IncrementAsync(player.UserId, robuxItemsData['Revive'].value)
			end)
			if success then
				player.Revive.Value = updatedRevive
			end
		elseif itemId == 'Boost' then
			local success, updatedBoost = pcall(function()
				return playerBoost:IncrementAsync(player.UserId, robuxItemsData['3Boosts'].value)
			end)
			if success then
				player.Boost.Value = updatedBoost
			end
		else
			local success, updatedEmerals = pcall(function()
				return playerEmerals:IncrementAsync(player.UserId, robuxItemsData[itemId].value)
			end)
			if success then
				player.Emerals.Value = updatedEmerals
				remotes.UpdateEmerals:FireClient(player)
			end
		end
		return true
end

---------------------------------------------------------------------------
---------------------------------------------------------------------------
-- SUPPORT FUNCTION

---------------------------------------------------------------------------
---------------------------------------------------------------------------
game.Players.PlayerAdded:Connect(mainfunc)
