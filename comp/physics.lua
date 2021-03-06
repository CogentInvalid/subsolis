--physics component: handles position, width, height, motion, and some collision stuff.

local component = require "comp/component"
local physics = class("physics", component)

function physics:initialize(args)
	component.initialize(self, args)
	self.type = "physics"
	
	self.collideOrder = {physics.isSolid, physics.isStatic}

	self.x = args.x; self.y = args.y
	self.px = self.x; self.py = self.y
	self.w = args.w; self.h = args.h

	self.vx = 0
	self.vy = 0
	
	--gravity not yet implemented
	self.gravity = args.gravity or false
	self.gravScale = args.gravScale or 300
	self.onGround = nil
	
	self.solidity = args.solidity

	self.col = args.col --does this collide with other objects?
	if args.col == nil then self.col = true end

	if self.col or self.solidity then
		self.world = self.game.colMan:addToWorld(self)
	end
end

function physics:destroy()
	self.world:remove(self)
end

--solid: moves other things
function physics.isSolid(other)
	return other.solidity == "solid"
end

--static: doesn't move & things don't move through it (even solid things)
function physics.isStatic(other)
	return other.solidity == "static"
end

function physics:update(dt)
	
	self.px = self.x
	self.py = self.y
	
	self.x = self.x + self.vx*dt
	self.y = self.y + self.vy*dt
	
	if self.gravity then
		self.vy = self.vy + self.gravScale*dt
	end
	
	self.onGround = false
end

function physics:hitSide(other, side)
	if side == "left" then
		self.x = other.x - self.w
		self.vx = other.vx
	end
	if side == "right" then
		self.x = other.x + other.w
		self.vx = other.vx
	end
	if side == "up" then
		self.y = other.y - self.h
		if self.gravity == true then self.onGround = true; if self.vy >= 0 then self.vy = 0.001 end
		else self.vy = other.vy end
	end
	if side == "down" then
		self.y = other.y + other.h
		self.vy = other.vy
	end
end

function physics:getPos()
	return self.x, self.y
end

function physics:setPos(x,y)
	self.x = x
	self.y = y
end

function physics:addPos(x,y)
	self.x = self.x + x
	self.y = self.y + y
end

function physics:setVel(x,y)
	self.vx = x
	self.vy = y
end

function physics:addVel(x,y)
	self.vx = self.vx + x
	self.vy = self.vy + y
end

return physics