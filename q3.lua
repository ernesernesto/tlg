-- Begin Q3
function do_sth_with_PlayerParty(playerId, membername)
   player = Player(playerId)
   local party = player:getParty()

   for k, v in pairs(party:getMembers()) do
      if v == Player(membername) then
         party:removeMember(Player(membername))
      end
   end
end

-- End Q3

-- Answer
-- I made the function name with camelCase, some lua style guide use snake_case because of standard library
-- but I use camelCase to make it consistent with the previous question
-- party:getMembers return array, so we need to check with ipairs
-- lastly we remove the player from the party based on the membername
function removePlayerFromParty(playerId, membername)
   local player = Player(playerId)
   local party = player:getParty()

   if party then
      for _, member in ipairs(party:getMembers()) do
         local checkName = member:getName()
         if checkName == memberName then
            party:removeMember(Player(membername))
         end
      end
   end
end
