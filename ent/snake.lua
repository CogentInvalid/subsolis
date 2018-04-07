local gameObject = require "ent/gameObject"
local snake = class("snake", gameObject)

local physics = require "comp/physics"
local rectangle = require "comp/render/rectangle"
local snakeAI = require "comp/snakeAI"

function snake:initialize(args)
	gameObject.initialize(self, args)
	self.id = "snake"
	
	local x = args.x or 100
	local y = args.y or 100

	self.phys = physics:new{parent=self, x=args.x, y=args.y, w=32, h=32, solidity="none"}
	self.rect = rectangle:new{
		parent=self, posParent=self.phys,
		w=32, h=32,
		color={r=0.2, g=0.5, b=0.5}
	}
	self.ai = snakeAI:new{parent=self, target=args.target}
	
	self:addComponent(self.rect)
	self:addComponent(self.phys)
	self:addComponent(self.ai)

end

return snake