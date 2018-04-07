local gameObject = require "ent/gameObject"
local player = class("player", gameObject)

local physics = require "comp/physics"
local rectangle = require "comp/render/rectangle"
local topDownController = require "comp/topDownController"

function player:initialize(args)
	gameObject.initialize(self, args)
	self.id = "player"
	
	local x = args.x or 100
	local y = args.y or 100

	self.phys = physics:new{parent=self, x=x, y=y, w=32, h=32, gravity=false}
	self.rect = rectangle:new{
		parent=self, posParent=self.phys,
		w=32, h=32,
		color={r=0.4, g=1, b=0.4}
	}
	self.controller = topDownController:new{parent=self, speed=350}
	
	self:addComponent(self.controller)
	self:addComponent(self.rect)
	self:addComponent(self.phys)
end

return player