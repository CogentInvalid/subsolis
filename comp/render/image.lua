--image component: handles drawing images to the screen.

local renderable = require "comp/render/renderable"

local image = class("image", renderable)

function image:initialize(args)
	renderable.initialize(self, args)
	self.type = "image"
	
	self.imgName = args.img
	self.img = getImg(args.img)
	
	self.w, self.h = self.img:getDimensions()

	self.sx = args.sx or 1

	self.offx = args.offx or 0
	self.offy = args.offy or 0

	self.rotation = args.rotation or 0
	
	--what we need to set quad:
	--xPos, yPos
	--width, height
	--tileWidth, tileHeight
	if args.quad ~= nil then
		local quad = args.quad
		self:setQuad(quad.xPos, quad.yPos, quad.w, quad.h, quad.tileWidth, quad.tileHeight)
	end

	self.animation = args.animation
	self.animSpeed = args.animSpeed or 1
	
end

function image:update(dt)
	renderable.update(self, dt)
	if self.animation then self.animation:update(self.animSpeed*dt) end
end

function image:setQuad(xPos, yPos, w, h, tileWidth, tileHeight)
	self.quad = love.graphics.newQuad((xPos-1)*tileWidth, (yPos-1)*tileHeight, w, h, self.img:getDimensions())
end

--draw the image
function image:draw()
	renderable.draw(self)
	local sx = self.sx; local sy = self.sx

	if self.animation then
		self.animation:draw(self.img, self.x+self.offx, self.y+self.offy, self.rotation, self.sx, sy, self.ox, self.oy)
	else
		if self.quad ~= nil then
			love.graphics.draw(self.img, self.quad, math.floor(self.x), math.floor(self.y), self.rotation, self.sx, sy, self.ox, self.oy)
		else
			love.graphics.draw(self.img, self.x+self.offx, self.y+self.offy, self.rotation, self.sx, sy, self.ox, self.oy)
		end
	end
end

function image:getX()
	return self.x-self.ox+self.offx-10
end

function image:getY()
	return self.y-self.oy+self.offy-10
end

function image:getW()
	return self.w*2+20
end

function image:getH()
	return self.h*2+20
end

return image