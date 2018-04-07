local gameObject = require "ent/gameObject"
local bottle = class("bottle", gameObject)

local physics = require "comp/physics"
local image = require "comp/render/image"

function bottle:initialize(args)
	gameObject.initialize(self, args)
	self.id = "bottle"
	
	self.phys = physics:new{parent=self, x=args.x, y=args.y, w=48, h=48, col=false, solidity="none"}
	
	self.img = image:new{
		parent=self, img=args.img,
		posParent=self.phys, quad=args.quad,
		drawLayer=args.drawLayer, sx=2,
	}

	self:addComponent(self.img)
	self:addComponent(self.phys)
end

return bottle