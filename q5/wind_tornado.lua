local area = createCombatArea({
	{ 0, 0, 0, 0, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 0, 1, 0, 1, 1, 0 },
	{ 1, 1, 1, 1, 3, 1, 1, 1, 1 },
	{ 0, 1, 1, 0, 1, 0, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 0, 0, 0 }
})

function spellCallback(cid, position, count)
	if Creature(cid) then
		if count > 0 or math.random(0, 1) == 1 then
			position:sendMagicEffect(CONST_ME_ICETORNADO)
			doAreaCombat(cid, COMBAT_ICEDAMAGE, position, 0, -10, -10, CONST_ME_ICETORNADO)
		end

		if count < 5 then
			count = count + 1
			addEvent(spellCallback, math.random(500, 1000), cid, position, count)
		end
	end
end

function onTargetTile(creature, position)
	spellCallback(creature:getId(), position, 0)
end

local combat = Combat()
combat:setArea(area)
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
