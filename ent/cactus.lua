local gameObject = require "ent/gameObject"
local cactus = class("cactus", gameObject)

local physics = require "comp/physics"
local image = require "comp/render/image"
local cactusComponent = require "comp/cactusComponent"

function cactus:initialize(args)
	gameObject.initialize(self, args)
	self.id = "cactus"
	
	self.phys = physics:new{parent=self, x=args.x+4, y=args.y+8, w=40, h=32, col=true, solidity="none"}
	
	self.img = image:new{
		parent=self, img=args.img,
		posParent=self.phys, quad=args.quad,
		drawLayer=args.drawLayer, sx=2,
		ox=2, oy=8
	}

	self:addComponent(self.img)
	self:addComponent(self.phys)
	self:addComponent(cactusComponent:new{parent=self})
end

return cactus