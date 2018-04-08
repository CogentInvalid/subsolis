local gameObject = require "ent/gameObject"
local player = class("player", gameObject)

local anim8 = require "libs/anim8"

local physics = require "comp/physics"
local image = require "comp/render/image"
local topDownController = require "comp/topDownController"
local shadeable = require "comp/shadeable"
local playerStats = require "comp/playerStats"
local playerAttack = require "comp/playerAttack"

function player:initialize(args)
	gameObject.initialize(self, args)
	self.id = "player"
	
	local x = args.x or 100
	local y = args.y or 100

	self.phys = physics:new{parent=self, x=x, y=y, w=32, h=32, gravity=false}

	local g = anim8.newGrid(24, 48, 24*4, 48*3)

	self.anim_down = anim8.newAnimation(g('1-4',1), 0.15)
	self.anim_left = anim8.newAnimation(g('1-4',2), 0.15)
	self.anim_right = anim8.newAnimation(g('1-4',2), 0.15)
	self.anim_up = anim8.newAnimation(g('1-4',3), 0.15)
	self.currentAnim = self.anim_right

	self.img = image:new{
		parent=self, posParent=self.phys,
		img="player", sx=2, sy=2,
		animation=self.currentAnim,
		ox=24/2, offx=16, offy=-62,
		drawLayer="player"
	}

	self.controller = topDownController:new{parent=self, speed=280}
	self.stats = playerStats:new{parent=self}
	self.shadeable = shadeable:new{parent=self}
	self.attack = playerAttack:new{parent=self}
	
	self:addComponent(self.controller)
	self:addComponent(self.img)
	self:addComponent(self.phys)
	self:addComponent(self.stats)
	self:addComponent(self.shadeable)
	self:addComponent(self.attack)

end

return player