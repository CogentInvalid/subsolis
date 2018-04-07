local mainMenu = {}

function mainMenu:init()
	self.fontTitle = love.graphics.newFont("/res/font/nanumbrushscript.ttf", 200)
	self.fontSubtitle = love.graphics.newFont("/res/font/nanumbrushscript.ttf", 40)
end

function mainMenu:enter()
	--love.graphics.setBackgroundColor(0,0,20/255)
end

function mainMenu:update(dt)
	
end

function mainMenu:draw()
	love.graphics.setColor(0.8, 0.7, 1)
	love.graphics.rectangle("fill", 0, 0, 2000, 2000)

	love.graphics.setColor(245/255, 245/255, 222/255)
	love.graphics.circle("fill", 512, 300, 180)

	love.graphics.setColor(1, 1, 0.5)
	love.graphics.rectangle("fill", 0, 500, 2000, 2000)

	love.graphics.setColor(0.8, 0.8, 0.3)

	local sw = love.graphics.getWidth()
	local sh = love.graphics.getHeight()

	love.graphics.setFont(self.fontTitle)
	local str = "subsolis"
	local w = love.graphics.getFont():getWidth(str)
	love.graphics.printf(str, sw/2-w/2, sh/4, 7000, 'left')

	love.graphics.setFont(self.fontSubtitle)
	str = "PRESS ENTER"
	w = love.graphics.getFont():getWidth(str)
	love.graphics.printf(str, sw/2-w/2, 540, 7000, 'left')
	
	love.graphics.setFont(courierCodeBold)
end

function mainMenu:startGame()
	gamestate.switch(gameMode.game)
end

function mainMenu:keypressed(key)
	self:startGame()
end

function mainMenu:mousepressed()
end

return mainMenu