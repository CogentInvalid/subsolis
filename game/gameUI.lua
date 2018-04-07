local gameUI = class("gameUI")

function gameUI:initialize(args)
	self.game = args.game
	self.player = args.player

	self.heatIcon = getImg("icon-heat")
	self.waterIcon = getImg("icon-water")
	self.healthIcon = getImg("icon-health")
	self.dangerIcon = getImg("icon-danger")
	self.bottleIcon = getImg("bottle_filled")
	self.hatIcon = getImg("hat")
end

function gameUI:draw(dt)
	local stats = self.player.stats
	local x, y = 0, 0

	--health
	x = 10; y = 640
	love.graphics.setColor(1,1,1)
	love.graphics.draw(self.healthIcon, x, y)
	love.graphics.setColor(.35, .2, .2)
	love.graphics.rectangle("fill", x+32, y, 200, 24)
	love.graphics.setColor(1, .4, .4)
	love.graphics.rectangle("fill", x+32, y, (stats.hp/stats.maxHP)*200, 24)

	--heat
	x = 10; y = 670
	love.graphics.setColor(1,1,1)
	love.graphics.draw(self.heatIcon, x, y)
	love.graphics.setColor(.35, .35, .2)
	love.graphics.rectangle("fill", x+32, y, 200, 24)
	love.graphics.setColor(1, .7, .2)
	if stats.dehydrated then love.graphics.setColor(1, .4, .2) end
	love.graphics.rectangle("fill", x+32, y, (stats.heat/stats.maxHeat)*200, 24)
	if stats.hasHat then
		love.graphics.setColor(1,1,1)
		love.graphics.draw(self.hatIcon, x+240, y)
	end

	--water
	x = 10; y = 700
	love.graphics.setColor(1,1,1)
	love.graphics.draw(self.waterIcon, x, y)
	love.graphics.setColor(.3, .3, .35)
	love.graphics.rectangle("fill", x+32, y, 200, 24)
	love.graphics.setColor(.4, .4, 1)
	local regularWater = math.min((stats.water/100), 1)
	love.graphics.rectangle("fill", x+32, y, regularWater*200, 24)
	if stats.dehydrated then
		love.graphics.setColor(1,1,1)
		love.graphics.draw(self.dangerIcon, x+232, y)
	end

	--bottle
	if stats.hasBottle then
		x = 10; y = 730
		love.graphics.setColor(1,1,1)
		love.graphics.draw(self.bottleIcon, x, y)
		love.graphics.setColor(.3, .3, .35)
		love.graphics.rectangle("fill", x+32, y, 80, 24)
		love.graphics.setColor(.4, .4, 1)
		local bottleWater = math.max((stats.water-100)/40, 0)
		love.graphics.rectangle("fill", x+32, y, bottleWater*80, 24)
	end
end

return gameUI