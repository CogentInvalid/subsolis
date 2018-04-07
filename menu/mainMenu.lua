local mainMenu = {}

function mainMenu:init()
	self.fontTitle = love.graphics.newFont("/res/font/couriercode-bold.ttf", 80)
	self.fontSubtitle = love.graphics.newFont("/res/font/couriercode-bold.ttf", 40)
end

function mainMenu:enter()
	--love.graphics.setBackgroundColor(0,0,20/255)
end

function mainMenu:update(dt)
	
end

function mainMenu:draw()
	love.graphics.setColor(0.5, 0.5, 0.9)

	local sw = love.graphics.getWidth()
	local sh = love.graphics.getHeight()

	love.graphics.setFont(self.fontTitle)
	local str = "TITLE SCREEN"
	local w = love.graphics.getFont():getWidth(str)
	love.graphics.printf(str, sw/2-w/2, sh/4, 7000, 'left')

	love.graphics.setFont(self.fontSubtitle)
	str = "PRESS ENTER"
	w = love.graphics.getFont():getWidth(str)
	love.graphics.printf(str, sw/2-w/2, sh/2, 7000, 'left')
	
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