-- Begin Q2
function printSmallGuildNames(memberCount)
   -- this method is supposed to print names of all guilds that have less than memberCount max members
   local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
   local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
   local guildName = result.getString("name")
   print(guildName)
end

-- End Q2

-- Answer
-- Not sure if the query is correct, but I can't seem to find max_members on the guilds table using TFS 1.4
-- the only available columns is id, name, ownerid, creationdata, motd, description, guild_logo, create_ip, balance
-- but assuming max_members available, here is the answer
function printSmallGuildNames(memberCount)
   assert(type(memberCount) == "number")

   local resultId = db.storeQuery(string.format("SELECT `name` FROM `guilds` WHERE `max_members` < %d", memberCount))
   if not resultId then
      print("No guild found with member less than " .. tostring(memberCount))
   else
      print("Guild names")
      repeat
         local guildName = result.getString(resultId, "name")
         print(guildName)
      until not result.next(resultId)
   end

   result.free(resultId)
end
