local component = require "comp/component"
local playerComponent = class("playerComponent", component)

function playerComponent:initialize(args)
	component.initialize(self, args)
	self.type = "playerComponent"
end

function playerComponent:collisionDetected(cols)
	--error(#cols)
	for i, col in ipairs(cols) do
		--debug(inspect(col))
	end
end

return playerComponent