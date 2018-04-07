function love.conf(t)
	t.window.title = "subsolis"
	t.window.width = 1000
	t.window.height = 750
	t.window.resizable = false
	t.window.vsync = false

	t.modules.joystick = false
	t.modules.physics = false
end