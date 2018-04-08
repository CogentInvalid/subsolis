local gameOver = {}

function gameOver:init()
	self.fontTitle = love.graphics.newFont("/res/font/nanumbrushscript.ttf", 200)
	self.fontSubtitle = love.graphics.newFont("/res/font/nanumbrushscript.ttf", 40)
end

function gameOver:enter()
	audio:clearAudio()
end

function gameOver:update(dt)
end

function gameOver:draw()
	love.graphics.setColor(0.05, 0.05, 0.08)
	love.graphics.rectangle("fill", 0, 0, 2000, 2000)

	--love.graphics.setColor(245/255, 245/255, 222/255)
	--love.graphics.circle("fill", 512, 300, 180)

	love.graphics.setColor(0.2, 0.2, 0.1)
	love.graphics.rectangle("fill", 0, 500, 2000, 2000)

	love.graphics.setColor(0.8, 0.8, 0.3)

	local sw = love.graphics.getWidth()
	local sh = love.graphics.getHeight()

	love.graphics.setFont(self.fontTitle)
	local str = "you died"
	local w = love.graphics.getFont():getWidth(str)
	love.graphics.printf(str, sw/2-w/2, sh/4, 7000, 'left')

	love.graphics.setFont(self.fontSubtitle)
	str = "PRESS ENTER"
	w = love.graphics.getFont():getWidth(str)
	love.graphics.printf(str, sw/2-w/2, 540, 7000, 'left')
	
	love.graphics.setFont(courierCodeBold)
end

function gameOver:startGame()
	gamestate.switch(gameMode.mainMenu)
end

function gameOver:keypressed(key)
	self:startGame()
end

function gameOver:mousepressed()
end

return gameOver