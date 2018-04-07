local gameUI = class("gameUI")

function gameUI:initialize(args)
	self.game = args.game
	self.player = args.player
end

function gameUI:draw(dt)
	local stats = self.player.stats
	local x, y = 0, 0

	--health
	x = 20; y = 670
	love.graphics.setColor(.35, .2, .2)
	love.graphics.rectangle("fill", x, y, 200, 24)
	love.graphics.setColor(1, .4, .4)
	love.graphics.rectangle("fill", x, y, (stats.hp/stats.maxHP)*200, 24)

	--heat
	x = 20; y = 700
	love.graphics.setColor(.35, .35, .2)
	love.graphics.rectangle("fill", x, y, 200, 24)
	love.graphics.setColor(1, .7, .2)
	love.graphics.rectangle("fill", x, y, (stats.heat/stats.maxHeat)*200, 24)

	--water
	x = 20; y = 730
	love.graphics.setColor(.3, .3, .35)
	love.graphics.rectangle("fill", x, y, 200, 24)
	love.graphics.setColor(.4, .4, 1)
	love.graphics.rectangle("fill", x, y, (stats.water/stats.maxWater)*200, 24)
end

return gameUI