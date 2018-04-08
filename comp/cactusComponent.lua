local component = require "comp/component"
local cactusComponent = class("cactusComponent", component)

function cactusComponent:initialize(args)
	component.initialize(self, args)
	self.type = "cactusComponent"
	self.hp = 5
	self.invuln = 0
end

function cactusComponent:update(dt)
	local damage = self.invuln/0.25
	self.parent.img.color = {r=1, g=1-0.5*damage, b=1-0.5-damage}

	if self.invuln > 0 then
		self.invuln = self.invuln - dt
		if self.invuln < 0 then self.invuln = 0 end
	end
end

function cactusComponent:takeDamage()
	self.hp = self.hp - 1
	self.invuln = 0.2
	if self.hp <= 0 then
		self:death()
	end
end

function cactusComponent:death()
	self.parent.die = true
	self.parent.game.player.stats:addWater(10)
	if love.math.random() < 0.1 then
		local x = self.parent.phys.x; local y = self.parent.phys.y
		self.parent.game:addEnt(require("ent/item"), {img="fruit", x=x-4, y=y-4, itemType="fruit"})
	end
end

function cactusComponent:collisionDetected(cols)
	for i, col in ipairs(cols) do
		if col.other.parent.id == "attack" and self.invuln <= 0 then
			self:takeDamage()
		end
	end
end

return cactusComponent