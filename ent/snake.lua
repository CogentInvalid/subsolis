local gameObject = require "ent/gameObject"
local snake = class("snake", gameObject)

local anim8 = require "libs/anim8"

local physics = require "comp/physics"
local image = require "comp/render/image"
local snakeAI = require "comp/snakeAI"

function snake:initialize(args)
	gameObject.initialize(self, args)
	self.id = "snake"
	
	local x = args.x or 100
	local y = args.y or 100

	self.phys = physics:new{parent=self, x=args.x, y=args.y, w=32, h=32, solidity="none"}

	local g = anim8.newGrid(24, 24, 96, 24)
	local anim = anim8.newAnimation(g('1-4',1), 0.15)

	self.img = image:new{
		parent=self, posParent=self.phys,
		img=properties.enemyImg,
		drawLayer = args.drawLayer, sx=2,
		animation = anim,
		ox = 12, oy = 12,
		offx = 14, offy = 14,
		rotation = 0
	}
	self.ai = snakeAI:new{parent=self, target=args.target}
	
	self:addComponent(self.img)
	self:addComponent(self.phys)
	self:addComponent(self.ai)

end

return snake