local component = require "comp/component"
local playerAttack = class("playerAttack", component)

local attack = require "ent/attack"

function playerAttack:initialize(args)
	component.initialize(self, args)
	self.type = "playerAttack"
end

function playerAttack:attack(x, y)
	local phys = self.parent.phys
	local px = phys.x+phys.w/2
	local py = phys.y+phys.h/2

	local dx = x-px; local dy = y-py
	local ang = math.atan2(dy, dx)

	x = px + math.cos(ang)*50
	y = py + math.sin(ang)*50
	self.game:addEnt(attack, {x=x, y=y, rotation=ang})

	audio:playSound("slash")
end

return playerAttack