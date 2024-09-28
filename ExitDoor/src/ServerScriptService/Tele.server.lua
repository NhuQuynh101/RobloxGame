-- -- Service 
-- local players = game:GetService('Players')
-- local teleportService = game:GetService('TeleportService')

-- local teamPlayers = {}

-- local lobby = workspace:WaitForChild('Lobby')
-- local graveA = workspace:WaitForChild('Lobby'):WaitForChild('GraveA')
-- local graveB = workspace:WaitForChild('Lobby'):WaitForChild('GraveB')

-- local mapID = 6557235320

-- for _, layPart in pairs(lobby:GetDescendants()) do
--     if layPart:IsA('Part') and layPart.Name == 'LayPart' then
--         layPart.Touched:Connect(function(hit)

--             local playerCharacter = hit.Parent
--             local area = layPart.Parent.Parent.Parent
--             area:WaitForChild('Waiting').Value = 0
--             if players:FindFirstChild(playerCharacter.Name) then
--                 layPart.Parent.Parent.ready.Value = playerCharacter
--                 for _, teleport in pairs(area:GetChildren()) do
--                     if teleport:IsA('Folder') then
--                         if teleport.ready.Value ~= nil then
--                             area:WaitForChild('Waiting').Value += 1
--                             print(teleport.ready.Value)
--                         end
--                     end
--                 end
--                 local limit = area:WaitForChild('Limit')
--                 local waiting = area:WaitForChild('Waiting')
                
--                 if waiting.Value == limit.Value then
--                     for _, teleport in pairs(area:GetChildren()) do
--                         if teleport:IsA('Folder') then
--                             if teleport.ready.Value ~= nil then
--                                 local player = players:GetPlayerFromCharacter(teleport.ready.Value)
--                                 table.insert(teamPlayers, player)
--                             end
--                         end
--                     end
--                         teleportService:TeleportAsync(mapID, teamPlayers)

--                 end
--             end
--         end)
--     end
-- end