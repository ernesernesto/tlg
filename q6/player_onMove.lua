local ec = EventCallback

ec.onMove = function(self, position, direction)
	position:getNextPosition(direction)

	local toTile = Tile(position)
	while toTile and toTile:isWalkable() do
		position:sendMagicEffect(CONST_ME_POFF)
		self:teleportTo(position)
		position:getNextPosition(direction)
		toTile = Tile(position)
	end
end

ec:register()
