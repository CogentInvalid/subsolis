local component = require "comp/component"
local topDownController = class("topDownController", component)

function topDownController:initialize(args)
	component.initialize(self, args)
	self.type = "topDownController"
	
	self.speed = args.speed or 200
	self.accel = args.accel or 6
	self.friction = args.friction or 3

	self.walking = false
	self.lastMove = "down"
	
	self.phys = self.parent:getComponent("physics")
end

function topDownController:update(dt)
	if not self.phys then self.phys = self.parent:getComponent("physics") end
	if self.phys == nil then crash("topDownController error: No physics component found") end
	
	local input = self.game.inputMan
	
	local movDir = {x=0, y=0}
	if input:keyDown("left") then movDir.x = movDir.x - 1; self.lastMove = "left" end
	if input:keyDown("right") then movDir.x = movDir.x + 1; self.lastMove = "right" end
	if input:keyDown("up") then movDir.y = movDir.y - 1; self.lastMove = "up" end
	if input:keyDown("down") then movDir.y = movDir.y + 1; self.lastMove = "down" end

	if movDir.x == 0 and movDir.y == 0 then
		self.walking = false
	else
		self.walking = true
		if self.lastMove == nil then
			--if input:keyDown("left") then self.lastMove = "left" end
			--if input:keyDown("right") then self.lastMove = "right" end
			--if input:keyDown("up") then self.lastMove = "up" end
			--if input:keyDown("down") then self.lastMove = "down" end
		end
	end

	self.parent.img.animation = self.parent["anim_"..self.lastMove]
	if self.lastMove == "left" then self.parent.img.sx = -2
	else self.parent.img.sx = 2 end
	if self.walking then
	else
		self.parent.img.animation:gotoFrame(1)
	end
	--debug("anim_"..self.lastMove)

	--movement
	local xMove = 0; local yMove = 0

	local speed = self.speed
	if self.parent.stats.inWater then speed = speed*0.4 end

	xMove = -(self.phys.vx - speed*movDir.x) * self.accel*dt
	yMove = -(self.phys.vy - speed*movDir.y) * self.accel*dt

	self.phys:addVel(xMove, yMove)

	--friction
	self.phys:addVel(-self.phys.vx*self.friction*dt, -self.phys.vy*self.friction*dt)
	
	--debug
	if keyDown("e") then self.phys.col = false else self.phys.col = true end
	
end

function topDownController:collisionDetected(cols)
	for i, col in ipairs(cols) do
		local id = col.other.parent.id
		if id == "cactus" or id == "snake" then
			if self.parent.stats.invuln <= 0 then
				local p1 = self.parent.phys
				local p2 = col.other.parent.phys
				local dx = (p1.x+p1.w/2)-(p2.x+p2.w/2)
				local dy = (p1.y+p1.h/2)-(p2.y+p2.h/2)
				local ang = math.atan2(dy, dx)
				self.phys.vx = math.cos(ang)*400
				self.phys.vy = math.sin(ang)*400
				audio:playSound("hit")
			end
			if id == "cactus" then self.parent.stats:loseHP(2) end
			if id == "snake" then self.parent.stats:loseHP(10) end
		end

		if id == "water" then
			self.parent.stats.inWater = true
		end

		if id == "item" then
			col.other.parent.die = true
			local type = col.other.parent.itemType
			if type == "bottle" then self.parent.stats:getBottle() end
			if type == "hat" then self.parent.stats:getHat() end
			if type == "part" then self.parent.stats:getPart() end
			if type == "fruit" then self.parent.stats:gainHP(8) end
			audio:playSound("pickup")
		end

	end
end

return topDownController