local component = require "comp/component"
local topDownController = class("topDownController", component)

function topDownController:initialize(args)
	component.initialize(self, args)
	self.type = "topDownController"
	
	self.speed = args.speed or 200
	self.accel = args.accel or 6
	self.friction = args.friction or 3
	
	self.phys = self.parent:getComponent("physics")
end

function topDownController:update(dt)
	if not self.phys then self.phys = self.parent:getComponent("physics") end
	if self.phys == nil then crash("topDownController error: No physics component found") end
	
	local input = self.game.inputMan
	
	local movDir = {x=0, y=0}
	if input:keyDown("left") then movDir.x = movDir.x - 1 end
	if input:keyDown("right") then movDir.x = movDir.x + 1 end
	if input:keyDown("up") then movDir.y = movDir.y - 1 end
	if input:keyDown("down") then movDir.y = movDir.y + 1 end

	--movement
	local xMove = 0; local yMove = 0

	local speed = self.speed
	if self.parent.stats.inWater then speed = speed/2 end

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
		if col.other.parent.id == "cactus" then
			if self.parent.stats.invuln <= 0 then
				local p1 = self.parent.phys
				local p2 = col.other.parent.phys
				local dx = (p1.x+p1.w/2)-(p2.x+p2.w/2)
				local dy = (p1.y+p1.h/2)-(p2.y+p2.h/2)
				local ang = math.atan2(dy, dx)
				self.phys.vx = math.cos(ang)*400
				self.phys.vy = math.sin(ang)*400
			end
			self.parent.stats:loseHP(2)
		end

		if col.other.parent.id == "water" then
			self.parent.stats.inWater = true
		end

		if col.other.parent.id == "bottle" then
			col.other.parent.die = true
			self.parent.stats:getBottle()
		end

		if col.other.parent.id == "hat" then
			col.other.parent.die = true
			self.parent.stats:getHat()
		end
	end
end

return topDownController