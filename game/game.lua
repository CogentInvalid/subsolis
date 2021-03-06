local collisionManager = require "game/collisionManager"
local cameraManager = require "game/cameraManager"
local inputManager = require "game/inputManager"
local tiledLoader = require "game/tiledLoader"
local gameUI = require "game/gameUI"

local player = require "ent/player"
local snake = require "ent/snake"
local wall = require "ent/wall"

local game = {}

function game:enter()

	love.graphics.setBackgroundColor(252/255, 231/255, 133/255)

	--timestep related stuff
	dt = 0.01
	accum = 0
	self.paused = false
	
	self.drawLayers = {"background", "default", "player", "foreground"}

	--systems
	self.system = {}
	self.colMan = self:addSystem(collisionManager)
	self.camMan = self:addSystem(cameraManager)
	self.inputMan = self:addSystem(inputManager)
	self.tiledLoader = self:addSystem(tiledLoader)

	--entities
	self.ent = {}
	--add player
	self.player = self:addEnt(player, {x=1460, y=1460})
	self.ui = self:addSystem(gameUI, {player=self.player})
	
	self.tiledLoader:loadLevel("test")
	local lw, lh = 4608, 4608
	self.camMan:setBounds(0, 0, lw, lh)
	self:addEnt(wall, {x=-24, y=0, w=24, h=lh})
	self:addEnt(wall, {x=0, y=-24, w=lw, h=24})
	self:addEnt(wall, {x=lw, y=0, w=24, h=lh})
	self:addEnt(wall, {x=0, y=lh, w=lw, h=24})
	
	--make camera follow player
	local phys = self.player:getComponent("physics")
	self.camMan:setTarget(phys, phys.w/2, phys.h/2)
	self.camMan:setPos(phys.x+phys.w/2, phys.y+phys.h/2)

	audio:playLooping("overworld")

end

function game:makeLevel()
	--crude level design
	for i=-5, 10 do
		for j=1, 3 do
			if((i==-3 and j==1) or (i==-2 and j==1)) then
				self:addEnt(wall, {x=400+i*50, y=100+j*50, w=50, h=50})
			else
				self:addEnt(wall, {x=400+i*50, y=100+j*50, w=50, h=50})
			end
		end
	end
	
	for i=-5, 10 do
		for j=1, 3 do
			self:addEnt(wall, {x=400+i*50, y=-350+j*50, w=50, h=50})
		end
	end
end

function game:loadLevel(name)
	self.tiledLoader:loadLevel(name)
	local phys = self.player:getComponent("physics")
	self.camMan:setTarget(phys, phys.w/2, phys.h/2)
	self.camMan:setPos(phys.x+phys.w/2, phys.y+phys.h/2)
end

function game:die()
	self.system[#self.system+1] = {
		timer=1,
		update = function(self, dt)
			self.timer = self.timer - dt
			if self.timer < 0 then gamestate.switch(gameMode.lose) end
		end
	}
end

function game:reset()
end

function game:update(delta)

	--debug(love.timer.getAverageDelta())

	--timestep stuff
	if self.paused == false then accum = accum + delta end
	if accum > 0.05 then accum = 0.05 end
	while accum >= dt do

		--reverse iterate entities
		for i, entity in lume.ripairs(self.ent) do
			--update entity
			entity:update(dt)

			--if die then is kill
			if entity.die then
				--destroy all components first
				entity:notifyComponents("destroy")
				table.remove(self.ent, i)
			end
		end
		
		--update systems
		for i, system in ipairs(self.system) do
			if system.update then system:update(dt) end
		end

		accum = accum - 0.01
	end
	if accum>0.1 then accum = 0 end
	
end

function game:draw()
	
	--attach camera
	self.camMan.cam:attach()

	--draw world
	local dim = self.camMan:getDimensions()
	for i, layer in ipairs(self.drawLayers) do
		for i, entity in ipairs(self.ent) do
			for i, comp in ipairs(entity.component) do
				if comp.drawLayer == layer then
					if comp:getX()+comp:getW() > dim.x and comp:getY()+comp:getH() > dim.y and
					comp:getX() < dim.x+dim.w and comp:getY() < dim.y+dim.h then
						comp:draw()
					end
				end
			end
		end
	end
	
	self.showHitboxes = false
	if self.showHitboxes then
		love.graphics.setColor(1,0,0,0.7)
		local cols, len = self.colMan.world:queryRect(0, 0, 4000, 4000)
		for i, phys in ipairs(cols) do
			love.graphics.rectangle("fill", phys.x, phys.y, phys.w, phys.h)
		end
	end
	
	--detach camera
	self.camMan.cam:detach()

	--draw ui
	for i, entity in ipairs(self.ent) do
		for i, comp in ipairs(entity.component) do
			if comp.drawLayer == "ui" then
				comp:draw()
			end
		end
	end

	for i, system in ipairs(self.system) do
		if system.draw then system:draw() end
	end

end

function game:keypressed(key)
	self.inputMan:keypressed(key)
	
	if key=="p" then
		gamestate.switch(gameMode.mainMenu)
	end

end

function game:mousepressed(x, y, button)
	self.inputMan:mousepressed(x, y, button)
end

function game:addSystem(sys, args)
	args = args or {}
	sys = sys:new(self, args)
	self.system[#self.system+1] = sys
	return sys
end

function game:addEnt(ent, args)
	args = args or {}
	args.game = self
	local entity = ent:new(args)
	self.ent[#self.ent+1] = entity
	return entity
end

function game:resize(w, h)
	self.camMan:setDimensions(w,h)
end

return game