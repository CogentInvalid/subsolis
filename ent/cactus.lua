local gameObject = require "ent/gameObject"
local cactus = class("cactus", gameObject)

local physics = require "comp/physics"
local image = require "comp/render/image"
local cactusComponent = require "comp/cactusComponent"

function cactus:initialize(args)
	gameObject.initialize(self, args)
	self.id = "cactus"
	
	local phys = physics:new{parent=self, x=args.x, y=args.y, w=48, h=48, col=true, solidity="static"}
	
	self.img = image:new{
		parent=self, img=args.img,
		posParent=phys, quad=args.quad,
		drawLayer=args.drawLayer, sx=2
	}

	self:addComponent(self.img)
	self:addComponent(phys)
	self:addComponent(cactusComponent:new{parent=self})
end

return cactus