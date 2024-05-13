local ec = EventCallback

local outfit = nil

ec.onMove = function(self, position, direction)
	position:getNextPosition(direction)

	local toTile = Tile(position)
	while toTile and toTile:isWalkable() do
		position:sendMagicEffect(CONST_ME_POFF)
		self:teleportTo(position)
		position:getNextPosition(direction)
		toTile = Tile(position)
	end

	outfit = self:getOutfit()
	rainbowEffect(self:getId(), outfit.lookType, 0)
end

ec:register()

function rainbowEffect(cid, lookType, index)
	local creature = Creature(cid)
	if index < 3 then
		local colors = { 94, 77, 79, 82, 87, 90 }
		creature:setOutfit({
			lookType = lookType,
			lookHead = colors[((index) % 6) + 1],
			lookBody = colors[((index + 1) % 6) + 1],
			lookLegs = colors[((index + 2) % 6) + 1],
			lookFeet = colors[((index + 3) % 6) + 1]
		})
		addEvent(rainbowEffect, 50, cid, lookType, index + 1)
	else
		creature:setOutfit(outfit)
	end
end
