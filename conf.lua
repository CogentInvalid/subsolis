function love.conf(t)
	t.window.title = "subsole"
	t.window.width = 1024
	t.window.height = 768
	t.window.resizable = false
	t.window.vsync = false

	t.modules.joystick = false
	t.modules.physics = false
end