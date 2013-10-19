game = {}

function game.init ()
	if ms.isVisible() then
		ms.setVisible(false)
	end

	p1 = Player()
	c = Cursor()
	mouse_timer = 0
	mouse_prev_loc = nil
end

function game.draw ()
	if c.mode == "select_box" then
		gr.setColor(255,255,255,255)
		gr.rectangle("line", mouse_prev_loc.x, mouse_prev_loc.y, 
					 ms.getX() - mouse_prev_loc.x, 
					 ms.getY() - mouse_prev_loc.y)
	end

	c:draw() -- draw cursor last
end

function game.update ( dt )
	local mouse_curr_loc = Vec( ms.getX(), ms.getY() )
	if ms.isDown("l") then
		if
			c.mode ~= "select_box"
			and mouse_prev_loc
			and	mouse_prev_loc:dist(mouse_curr_loc) > 2
		then
			c.mode = "select_box"
			c.select_img = "smaller"
		elseif
			c.mode ~= "single_click"
			and mouse_prev_loc
			and mouse_prev_loc:dist(mouse_curr_loc) <= 2
		then
			c.mode = "single_click"
		end
	end
end

function game.mousepressed ( x, y, button )
	mouse_prev_loc = Vec( ms.getX(), ms.getY() )
end

function game.mousereleased ( x, y, button )
	if c.mode == "select_box" then
		
	elseif c.mode == "single_click" then
			
	end
	
	c.mode = "normal"
	c.select_img = "normal"
end

function game.keypressed ( key )
	if key == "escape" then
		ev.push("quit")
	end
	if key == "a" then
		c.select_img = "red"
	end
end
