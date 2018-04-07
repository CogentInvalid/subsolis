local component = require "comp/component"
local snakeAI = class("snakeAI", component)

function snakeAI:initialize(args)
	component.initialize(self, args)
	self.type = "snakeAI"
	self.phys = self.parent.phys
	self.target = args.target or self.parent.game.player

	self.home = {x=self.phys.x, y=self.phys.y, w=0, h=0}

	self:startIdle()

end

function snakeAI:update(dt)
	self[self.mode](self, dt)
end

function snakeAI:startIdle()
	local r = love.math.random()
	if r > 0.4 then self:startWander()
	else self:startWait() end
end

function snakeAI:startWander()
	self.mode = "wander"
	local dx, dy = self:getDiff(self.home)
	if math.sqrt(dx*dx + dy*dy) > 150 then
		self.wanderDir = math.atan2(dy, dx)
	else
		self.wanderDir = love.math.random()*2*math.pi
	end
	self.wanderTimer = 1+love.math.random()*2
end

function snakeAI:wander(dt)
	self.parent.img.animSpeed = 1
	self.parent.img.rotation = self.wanderDir
	self.phys.vx = math.cos(self.wanderDir)*30
	self.phys.vy = math.sin(self.wanderDir)*30
	self.wanderTimer = self.wanderTimer - dt
	if self.wanderTimer < 0 then
		self:startIdle()
	end

	if self:playerInRange() then self:startChase() end
end

function snakeAI:startWait()
	self.mode = "wait"
	self.waitTimer = 1+love.math.random()
	self.phys.vx = 0; self.phys.vy = 0
end

function snakeAI:wait(dt)
	self.parent.img.animSpeed = 0.5
	self.waitTimer = self.waitTimer - dt
	if self.waitTimer < 0 then
		self:startIdle()
	end

	if self:playerInRange() then self:startChase() end
end

function snakeAI:getDiff(target)
	local p = target
	local px = p.x+p.w/2; local py = p.y+p.h/2
	local sx = self.phys.x+self.phys.w/2; local sy = self.phys.y+self.phys.h/2
	local dx = px-sx; local dy = py-sy
	return dx, dy
end

function snakeAI:angleToPlayer()
	local dx, dy = self:getDiff(self.target.phys)
	return math.atan2(dy, dx)
end

function snakeAI:playerInRange()
	local dx, dy = self:getDiff(self.target.phys)
	local dist = math.sqrt(dx*dx + dy*dy)
	if dist < 175 then return true end
end

function snakeAI:startChase()
	self.mode = "chase"
	self.timer = 1
	self.paused = false
	self.chaseAngle = self:angleToPlayer()
end

function snakeAI:chase(dt)
	if self.paused then
		self.parent.img.animSpeed = 0.5
		self.timer = self.timer - dt
		if self.timer < 0 then
			self.paused = false
			self.timer = 0.3+math.random()*0.5
			self.chaseAngle = self:angleToPlayer()
		end
	else
		self.parent.img.animSpeed = 2
		self.phys.vx = math.cos(self.chaseAngle)*200
		self.phys.vy = math.sin(self.chaseAngle)*200
		self.parent.img.rotation = self.chaseAngle

		self.timer = self.timer - dt
		if self.timer < 0 then
			self.paused = true
			self.phys.vx = 0; self.phys.vy = 0
			self.timer = 0.1+math.random()*0.5
		end
	end

	if not self:playerInRange() then self:startIdle() end
end

return snakeAI