local component = require "comp/component"
local fade = class("fade", component)

function fade:initialize(args)
	component.initialize(self, args)
	self.type = "fade"
	self.dir = args.dir
end

function fade:update(dt)
	local img = self.parent:getComponent("image")
	img.color.a = img.color.a + self.dir*dt
	if img.color.a < 0 then img.color.a = 0 end
	if img.color.a > 1 then img.color.a = 1 end
end

return fade