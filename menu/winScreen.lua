local anim8 = require "libs/anim8"

local winScreen = {}

function winScreen:init()
	self.fontTitle = love.graphics.newFont("/res/font/nanumbrushscript.ttf", 200)
	self.fontSubtitle = love.graphics.newFont("/res/font/nanumbrushscript.ttf", 40)

	self.heli = getImg("helicopter")
	local g = anim8.newGrid(72, 48, 288, 48)
	self.anim = anim8.newAnimation(g('1-4',1), 0.02)
	self.heliX = 470
	self.timerX = 0
	self.heliY = 400
	self.timerY = 0

end

function winScreen:enter()
	audio:clearAudio()
end

function winScreen:update(dt)
	self.timerX = self.timerX + dt
	self.timerY = self.timerY + dt

	self.heliX = self.heliX + math.sin(self.timerX*0.8)*50*dt
	self.heliY = self.heliY + math.cos(self.timerY)*50*dt

	self.anim:update(dt)
end

function winScreen:draw()
	love.graphics.setColor(0.8, 0.7, 1)
	love.graphics.rectangle("fill", 0, 0, 2000, 2000)

	love.graphics.setColor(245/255, 245/255, 222/255)
	love.graphics.circle("fill", 512, 300, 180)

	love.graphics.setColor(1, 1, 0.5)
	love.graphics.rectangle("fill", 0, 500, 2000, 2000)

	local sw = love.graphics.getWidth()
	local sh = love.graphics.getHeight()

	love.graphics.setColor(1,1,1)
	self.anim:draw(self.heli, self.heliX, self.heliY, math.sin(self.timerX*1.5)*0.1, -2, 2, 72/2, 48/2)

	love.graphics.setColor(0.8, 0.8, 0.3)
	love.graphics.setFont(self.fontTitle)
	local str = "you escaped"
	local w = love.graphics.getFont():getWidth(str)
	love.graphics.printf(str, sw/2-w/2, sh/4, 7000, 'left')

	love.graphics.setFont(self.fontSubtitle)
	str = "PRESS ENTER"
	w = love.graphics.getFont():getWidth(str)
	love.graphics.printf(str, sw/2-w/2, 540, 7000, 'left')
	
	love.graphics.setFont(courierCodeBold)
end

function winScreen:keypressed(key)
	gamestate.switch(gameMode.mainMenu)
end

function winScreen:mousepressed()
end

return winScreen