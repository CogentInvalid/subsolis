local component = require "comp/component"
local playerComponent = class("playerComponent", component)

function playerComponent:initialize(args)
	component.initialize(self, args)
	self.type = "playerComponent"

	self.inShade = false
end

function playerComponent:update(dt)
	if self.inShade then
		self.parent.rect.color = {r=0.2, g=0.5, b=0.2}
	else
		self.parent.rect.color = {r=0.2, g=0.7, b=0.2}
	end

	self.inShade = false
end

function playerComponent:collisionDetected(cols)
	for i, col in ipairs(cols) do
		if col.other.parent.id == "shade" then
			self.inShade = true
		end
	end
end

return playerComponent