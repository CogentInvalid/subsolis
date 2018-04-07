local gameObject = require "ent/gameObject"
local attack = class("attack", gameObject)

local physics = require "comp/physics"
local rectangle = require "comp/render/rectangle"
local image = require "comp/render/image"
local lifespan = require "comp/lifespan"
local fade = require "comp/fade"

function attack:initialize(args)
	gameObject.initialize(self, args)
	self.id = "attack"

	local phys = physics:new{parent=self, x=args.x, y=args.y, w=16, h=16, col=false}
	
	self.img = image:new{
		parent=self, img="slash",
		posParent=phys, quad=args.quad,
		drawLayer=args.drawLayer, sx=2,
		ox=8, oy=8,
		rotation=args.rotation
	}

	self:addComponent(self.img)
	self:addComponent(phys)
	self:addComponent(lifespan:new{parent=self, time=0.2})
	self:addComponent(fade:new{parent=self, dir=-5})
end

return attack