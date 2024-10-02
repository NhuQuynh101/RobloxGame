local replicatedStorage = game:GetService("ReplicatedStorage")	
local players = game:GetService("Players")

-- ReplicatedStorage
local remotes = replicatedStorage.Remotes

game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new('Folder')
	leaderstats.Name = 'leaderstats'
	leaderstats.Parent = player
	
	local rank = Instance.new('IntValue')
	rank.Name = 'Rank'
	rank.Parent = leaderstats
		
	local Time = Instance.new('NumberValue')
	Time.Name = 'Time'
	Time.Parent = leaderstats
end)

