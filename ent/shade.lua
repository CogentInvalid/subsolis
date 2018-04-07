local gameObject = require "ent/gameObject"
local shade = class("shade", gameObject)

local physics = require "comp/physics"
local rectangle = require "comp/render/rectangle"
local image = require "comp/render/image"

function shade:initialize(args)
	gameObject.initialize(self, args)
	self.id = "shade"
	
	local phys = physics:new{parent=self, x=args.x, y=args.y, w=48, h=48, col=false}
	
	self.img = image:new{
		parent=self, img=args.img,
		posParent=phys, quad=args.quad,
		drawLayer=args.drawLayer, sx=2
	}

	self:addComponent(self.img)
	self:addComponent(phys)
end

return shade