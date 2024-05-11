-- Begin Q1
local function releaseStorage(player)
   player:setStorageValue(1000, -1)
end

function onLogout(player)
   if player:getStorageValue(1000) == 1 then
      addEvent(releaseStorage, 1000, player)
   end
   return true
end

-- End Q1

-- Answer
-- In this context, assuming this is a login logout logic so 1000 should be used as loginStatus
PlayerStorageKeys = {
   loginStatus = 1000,
   -- other keys for player can go below..
}

local function releaseStorage(player)
   player:setStorageValue(PlayerStorageKeys.loginStatus, -1)
end

function onLogout(player)
   if player:getStorageValue(PlayerStorageKeys.loginStatus) == 1 then
      addEvent(releaseStorage, 1000, player)
   end

   return true
end
