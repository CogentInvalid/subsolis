local component = require "comp/component"
local playerStats = class("playerStats", component)

function playerStats:initialize(args)
	component.initialize(self, args)
	self.type = "playerStats"
	
	self.maxHP = 100; self.hp = self.maxHP
	self.invuln = 0
	self.maxWater = 80; self.water = self.maxWater
	self.maxHeat = 100; self.heat = 0
	self.hasBottle = false
	self.dehydrated = false
	self.inWater = false
	self.parts = 0
end

function playerStats:update(dt)

	if self.invuln > 0 then
		self.invuln = self.invuln - dt
		if self.invuln < 0 then self.invuln = 0 end
	end

	local heatRate = (100/24)
	if self.hasHat then heatRate = heatRate*0.6 end

	if self.parent.shadeable.inShade then
		self.heat = self.heat - (100/20)*dt
	else
		self.heat = self.heat + heatRate*dt
	end

	if self.heat > 90 then
		self.dehydrated = true
		self:addWater(-(100/30)*dt)
	else
		self.dehydrated = false
		self:addWater(-(100/120)*dt)
	end

	if self.heat > self.maxHeat then self.heat = self.maxHeat end
	if self.heat < 0 then self.heat = 0 end

	if self.inWater then
		self:addWater(10*dt)
		self:addHeat(-10*dt)
	end
	self.inWater = false

	if self.water <= 0 then
		self:loseHP(10*dt, true)
	end

end

function playerStats:getBottle()
	self.hasBottle = true
	self.maxWater = self.maxWater + 40
end

function playerStats:getHat()
	self.hasHat = true
end

function playerStats:addWater(amt)
	self.water = self.water + amt

	if self.water > self.maxWater then self.water = self.maxWater end
	if self.water < 0 then self.water = 0 end
end

function playerStats:addHeat(amt)
	self.heat = self.heat + amt
	if self.heat > 100 then self.heat = 100 end
	if self.heat < 0 then self.heat = 0 end
end

function playerStats:loseHP(amt, ignoreInvuln)
	if ignoreInvuln or self.invuln <= 0 then
		self.invuln = 0.25
		self.hp = self.hp - amt
		if self.hp <= 0 then self.hp = 0; self:death() end
	end
end

function playerStats:death()
	self.parent.die = true
end

function playerStats:getPart()
	self.parts = self.parts + 1
end

return playerStats