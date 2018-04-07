local gameObject = require "ent/gameObject"
local water = class("water", gameObject)

local physics = require "comp/physics"
local image = require "comp/render/image"

function water:initialize(args)
	gameObject.initialize(self, args)
	self.id = "water"
	
	local phys = physics:new{parent=self, x=args.x, y=args.y, w=48, h=48, col=false, solidity="none"}
	
	self.img = image:new{
		parent=self, img=args.img,
		posParent=phys, quad=args.quad,
		drawLayer=args.drawLayer, sx=2
	}

	self:addComponent(self.img)
	self:addComponent(phys)
end

return water