--libraries
class = require "libs/middleclass"
require "libs/misc"
vector = require "libs/vector"
inspect = require "libs/inspect"
lume = require "libs/lume"
gamestate = require "libs/hump/gamestate"

imgMan = require "imgManager"
audio = require "audio"

--gamestates
gameMode = {}
gameMode.mainMenu = require "menu/mainMenu"
gameMode.game = require "game/game"
gameMode.lose = require "menu/gameOver"

--other things
debugger = require "debugger"

function love.load()

	--setup ZeroBrane IDE debugger (only relevant if using that IDE)
	if arg[#arg] == "-debug" then require("mobdebug").start() end
	--usage: require("mobdebug").on(); require("mobdebug").off()
	
	love.graphics.setDefaultFilter("linear", "nearest")

	math.randomseed(os.time())
	
	courierCodeBold = love.graphics.newFont("/res/font/couriercode-bold.ttf", 24)
	love.graphics.setFont(courierCodeBold)
	
	local volume = 1
	local mute = false
	audio:setVolume(volume)
	if mute then audio:mute() end

	--gamestate.registerEvents()

	--explicitly register all events except joystick ones (crashes in love 0.11)
	--also, no draw event (defined manually below)
	gamestate.registerEvents{
		'init', 'enter', 'leave',
		'resume', 'focus',
		'update', 'quit',
		'keypressed', 'keyreleased',
		'mousepressed', 'mousereleased',
	}
	gamestate.switch(gameMode.lose)
end

function love.update(dt)
	debugger:update(dt)
end

function love.draw()
	gamestate.current():draw()
	debugger:draw()
end

function love.keypressed(key)
	if key == "escape" then 
		love.event.quit()
	end
end

function debug(message, duration, concat)
	duration = duration or 5
	if concat then debugger:cat(message, duration)
	else debugger:print(message, duration) end
end

function getImg(name)
	return imgMan:getImage(name)
end