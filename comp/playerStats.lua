local component = require "comp/component"
local playerStats = class("playerStats", component)

function playerStats:initialize(args)
	component.initialize(self, args)
	self.type = "playerStats"
	
	self.maxHP = 100; self.hp = self.maxHP
	self.maxWater = 100; self.water = self.maxWater
	self.maxHeat = 100; self.heat = 0
	self.dehydrated = false
end

function playerStats:update(dt)

	if self.parent.shadeable.inShade then
		self.heat = self.heat - (100/30)*dt
	else
		self.heat = self.heat + (100/30)*dt
	end

	if self.heat > 90 then
		self.dehydrated = true
		self.water = self.water - (100/30)*dt
	else
		self.dehydrated = false
		self.water = self.water - (100/120)*dt
	end

	if self.heat > self.maxHeat then self.heat = self.maxHeat end
	if self.heat < 0 then self.heat = 0 end

	if self.water > self.maxWater then self.water = self.maxWater end
	if self.water < 0 then
		self.water = 0
		--TODO: die
	end

end

return playerStats