local component = require "comp/component"
local snakeAI = class("snakeAI", component)

function snakeAI:initialize(args)
	component.initialize(self, args)
	self.type = "snakeAI"
	self.phys = self.parent.phys
	self.target = args.target

	self.home = {x=self.phys.x, y=self.phys.y}

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
	self.wanderDir = love.math.random()*2*math.pi
	self.wanderTimer = 1+love.math.random()*2
end

function snakeAI:wander(dt)
	self.phys.vx = math.cos(self.wanderDir)*30
	self.phys.vy = math.sin(self.wanderDir)*30
	self.wanderTimer = self.wanderTimer - dt
	if self.wanderTimer < 0 then
		self:startIdle()
	end

	self:checkForPlayer(dt)
end

function snakeAI:startWait()
	self.mode = "wait"
	self.waitTimer = 1+love.math.random()
	self.phys.vx = 0; self.phys.vy = 0
end

function snakeAI:wait(dt)
	self.waitTimer = self.waitTimer - dt
	if self.waitTimer < 0 then
		self:startIdle()
	end

	self:checkForPlayer(dt)
end

function snakeAI:checkForPlayer(dt)

end

return snakeAI